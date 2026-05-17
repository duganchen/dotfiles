-- Reading https://neovim.io/doc/user/pack
-- Anyway, ChatGPT wrote this, with instructions to put it before
-- vim.pack.add.
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		if ev.data.spec.name == "telescope-fzf-native.nvim" then
			vim.system({ "make" }, {
				cwd = ev.data.path,
			}):wait()
		end
	end,
})


vim.pack.add { { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	'https://github.com/neovim/nvim-lspconfig',
	-- still want this Tim Pope plugin
	'git@github.com:tpope/vim-sleuth.git',
	'https://github.com/nvim-tree/nvim-web-devicons',
	'git@github.com:nvim-lualine/lualine.nvim.git',
	-- It's too early to care that this is "archived."
	'git@github.com:nvim-treesitter/nvim-treesitter.git',
	'git@github.com:nvim-lua/plenary.nvim.git',
	'git@github.com:nvim-telescope/telescope.nvim.git',
	'git@github.com:nvim-telescope/telescope-fzf-native.nvim.git',
	-- for neocmake
	'git@github.com:L3MON4D3/LuaSnip.git',
	'git@github.com:hjson/vim-hjson.git',
	'https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git',
	-- Let's replace the standard Tim Pope plugins
	'git@github.com:nvim-mini/mini.basics.git', -- sensible
	'git@github.com:nvim-mini/mini.surround.git', -- surround

	-- For the file tree.
	-- https://www.reddit.com/r/neovim/comments/1r363ad/why_dont_you_use_a_file_explorer_nvimtree_neotree/
	'git@github.com:/folke/snacks.nvim',

	'git@github.com:mason-org/mason.nvim.git',
	'git@github.com:folke/which-key.nvim.git',
	'git@github.com:nvim-treesitter/nvim-treesitter-textobjects.git'

}
require('catppuccin').setup({ transparent_background = true })

require('nvim-treesitter').install({ 'bash', 'c', 'cpp', 'cmake', 'css', 'fish', 'go', 'hjson', 'html', 'javascript',
	'json', 'lua',
	'markdown',
	'python', 'toml',
	'yaml' })

require('nvim-treesitter-textobjects').setup()

require('telescope').setup({})
require('telescope').load_extension('fzf')

require('mini.basics').setup()
require('mini.surround').setup()

require('mason').setup()

require('snacks').setup()

-- Note that mini.basics has set the leader key to space
-- These are what Ctrl-T provided by default.
-- Keybindings match Helix.
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>j', builtin.jumplist, { desc = 'List Jump List entries' })
-- And from Helix
vim.keymap.set('n', '<leader>e', Snacks.explorer.open, { desc = 'open the explorer picker' })
vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = 'Telescope live grep' })

-- not using cmake-language-server because of this:
-- https://github.com/regen100/cmake-language-server/issues/108

-- These generally follow the languages.toml file I've set up for Helix, and are meant to run
-- on the same system.
vim.lsp.enable({ 'bashls', 'clangd', 'eslint', 'neocmake', 'cssls', 'fish_lsp', 'gopls', 'html', 'jsonls', 'lua_ls',
	'marksman',
	'ruff',
	'tombi',
	'yamlls' })

require('lualine').setup()

vim.cmd.colorscheme "catppuccin-macchiato"

-- Remember: ctrl+n and ctrl+p
vim.o.autocomplete = true
-- https://www.reddit.com/r/neovim/comments/1pd6pg8/comment/ns4yopi/
vim.o.complete = "o,.,w,b,u"
vim.o.completeopt = "fuzzy,menuone,noselect,popup"

-- This should use TreeSitter for folding?
-- They're from this video:
-- https://youtu.be/lljs_7xB7Ps?si=1ayi3G1osYr3Nq_k
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- start with folds open
vim.opt.foldlevel = 99


vim.lsp.config('lua_ls', {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
			    path ~= vim.fn.stdpath('config')
			    and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using (most
				-- likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
				-- Tell the language server how to find Lua modules same way as Neovim
				-- (see `:h lua-module-load`)
				path = {
					'lua/?.lua',
					'lua/?/init.lua',
				},
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					-- For LSP Settings Type Annotations: https://github.com/neovim/nvim-lspconfig#lsp-settings-type-annotations
					vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1],
					-- Depending on the usage, you might want to add additional paths
					-- here.
					-- '${3rd}/luv/library',
					-- '${3rd}/busted/library',
				},
				-- Or pull in all of 'runtimepath'.
				-- NOTE: this is a lot slower and will cause issues when working on
				-- your own configuration.
				-- See https://github.com/neovim/nvim-lspconfig/issues/3189
				-- library = vim.api.nvim_get_runtime_file('', true),
			},
		})
	end,
	settings = {
		Lua = {},
	},
})

-- copy and paste from
-- https://dotfiles.substack.com/p/native-lsp-in-neovim-012
vim.diagnostic.config({
	severity_sort = true,
	update_in_insert = false,
	float = {
		border = 'rounded',
		source = 'if_many',
	},
	underline = true,
	virtual_text = {
		spacing = 2,
		source = 'if_many',
		prefix = '●',
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = 'E',
			[vim.diagnostic.severity.WARN] = 'W',
			[vim.diagnostic.severity.INFO] = 'I',
			[vim.diagnostic.severity.HINT] = 'H',
		},
	},
})

-- copy and paste from
-- https://www.mitchellhanberg.com/modern-format-on-save-in-neovim/
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp", { clear = true }),
	callback = function(args)
		-- 2
		vim.api.nvim_create_autocmd("BufWritePre", {
			-- 3
			buffer = args.buf,
			callback = function()
				-- 4 + 5
				vim.lsp.buf.format { async = false, id = args.data.client_id }
			end,
		})
	end
})

-- This is an attempt to use nvim-treesitter-textobjects to replicate Helix's text objects

require("nvim-treesitter-textobjects").setup {
	select = {
		-- Automatically jump forward to textobj, similar to targets.vim
		lookahead = true,
		-- You can choose the select mode (default is charwise 'v')
		--
		-- Can also be a function which gets passed a table with the keys
		-- * query_string: eg '@function.inner'
		-- * method: eg 'v' or 'o'
		-- and should return the mode ('v', 'V', or '<c-v>') or a table
		-- mapping query_strings to modes.
		selection_modes = {
			['@parameter.outer'] = 'v', -- charwise
			['@function.outer'] = 'V', -- linewise
			['@class.outer'] = '<c-v>', -- blockwise
		},
	},
	-- If you set this to `true` (default is `false`) then any textobject is
	-- extended to include preceding or succeeding whitespace. Succeeding
	-- whitespace has priority in order to act similarly to eg the built-in
	-- `ap`.
	--
	-- Can also be a function which gets passed a table with the keys
	-- * query_string: eg '@function.inner'
	-- * selection_mode: eg 'v'
	-- and should return true of false
	include_surrounding_whitespace = false,
}

-- keymaps
-- You can use the capture groups defined in `textobjects.scm`

-- function
vim.keymap.set({ "x", "o" }, "af", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
end)

-- class/type
vim.keymap.set({ "x", "o" }, "at", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "it", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
end)

-- parameter
vim.keymap.set({ "x", "o" }, "aa", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@parameter.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ia", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@parameter.inner", "textobjects")
end)

-- comment
vim.keymap.set({ "x", "o" }, "ac", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@comment.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@comment.inner", "textobjects")
end)

-- And movement now

-- configuration
require("nvim-treesitter-textobjects").setup {
	move = {
		-- whether to set jumps in the jumplist
		set_jumps = true,
	},
}

-- function

vim.keymap.set({ "n", "x", "o" }, "]f", function()
	require("nvim-treesitter-textobjects.move").goto_next("@function.outer", "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "[f", function()
	require("nvim-treesitter-textobjects.move").goto_previous("@function.outer", "textobjects")
end)

-- class/type

vim.keymap.set({ "n", "x", "o" }, "]t", function()
	require("nvim-treesitter-textobjects.move").goto_next("@class.outer", "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "[t", function()
	require("nvim-treesitter-textobjects.move").goto_previous("@class.outer", "textobjects")
end)

-- parameter/argument

vim.keymap.set({ "n", "x", "o" }, "]a", function()
	require("nvim-treesitter-textobjects.move").goto_next("@parameter.outer", "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "[a", function()
	require("nvim-treesitter-textobjects.move").goto_previous("@parameter.outer", "textobjects")
end)

-- comment
vim.keymap.set({ "n", "x", "o" }, "]c", function()
	require("nvim-treesitter-textobjects.move").goto_next("@comment.outer", "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "[c", function()
	require("nvim-treesitter-textobjects.move").goto_previous("@comment.outer", "textobjects")
end)
