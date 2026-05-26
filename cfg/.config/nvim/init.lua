-- Note: To clean out unused packages, do:
-- :lua vim.pack.update(nil, { offline = true })
-- "gra" on (not active) packages
-- https://www.reddit.com/r/neovim/comments/1r92p2y/comment/o69dr8l/

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
	end
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
	-- for neocmake
	'git@github.com:L3MON4D3/LuaSnip.git',
	'git@github.com:hjson/vim-hjson.git',
	'https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git',
	-- Let's replace the standard Tim Pope plugins
	'git@github.com:nvim-mini/mini.basics.git', -- sensible
	'git@github.com:nvim-mini/mini.surround.git', -- surround
	'git@github.com:nvim-mini/mini.clue.git',
	'git@github.com:nvim-mini/mini.files.git',
	'git@github.com:nvim-mini/mini.icons.git',
	'git@github.com:nvim-mini/mini.ai.git',
	'git@github.com:nvim-mini/mini.completion.git',
	'git@github.com:nvim-mini/mini.pick.git',
	'git@github.com:nvim-mini/mini.bracketed.git',
	{ src = 'git@github.com:nvim-mini/mini.extra.git', version = 'stable' },

	'git@github.com:mason-org/mason.nvim.git',

	-- Neither Kickstart nor LazyVim use fugitive, so
	'git@github.com:lewis6991/gitsigns.nvim.git',

	'git@github.com:j-hui/fidget.nvim.git',

	'git@github.com:mfussenegger/nvim-dap.git',
	'git@github.com:jay-babu/mason-nvim-dap.nvim.git',
	'git@github.com:rcarriga/nvim-dap-ui.git',
	'git@github.com:theHamsta/nvim-dap-virtual-text.git'


}
require('catppuccin').setup({ transparent_background = true })

require('fidget').setup()

require('nvim-treesitter').install({ 'bash', 'c', 'cpp', 'cmake', 'css', 'fish', 'go', 'hjson', 'html', 'javascript',
	'json', 'lua',
	'markdown',
	'python', 'toml',
	'yaml' })

require('mini.ai').setup()
require('mini.basics').setup()
require('mini.surround').setup()
require('mini.files').setup()
require('mini.icons').setup()
require('mini.completion').setup()
require('mini.pick').setup()
require('mini.bracketed').setup()
require('mini.extra').setup()


-- mini.clue is set up below

require('mason').setup()
require('mason-nvim-dap').setup()
require('nvim-dap-virtual-text').setup()

-- these are from lazyvim
require('gitsigns').setup({
	signs = {
		add = { text = '' },
		change = { text = ' ' },
		delete = { text = '' }

	}
})

-- Note that mini.basics has set the leader key to space
-- Mostly using Kickstart's setup, which starts finders with "<space>" s.
-- No jumplist though. Telescope has it, but AFAIK mini.pick doesn't
vim.keymap.set('n', '<leader>sb', MiniPick.builtin.buffers, { desc = '[S]earch [B]uffers' })
vim.keymap.set('n', '<leader>sf', MiniPick.builtin.files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>e', MiniFiles.open, { desc = 'open the explorer picker' })
-- Or <leader>/
vim.keymap.set('n', '<leader>sg', MiniPick.builtin.grep_live, { desc = '[S]search by [G]rep' })
-- from lazyvim
function WorkspaceSymbolSearch()
	MiniExtra.pickers.lsp({ scope = 'workspace_symbol' })
end

vim.keymap.set('n', '<leader>sS',
	WorkspaceSymbolSearch, { desc = '[S]search [S]ymbols (workspace)' })

function DocumentSymbolSearch()
	MiniExtra.pickers.lsp({ scope = 'document_symbol' })
end

vim.keymap.set('n', '<leader>ss',
	DocumentSymbolSearch, { desc = '[S]search [s]ymbols (document)' })

-- not using cmake-language-server because of this:
-- https://github.com/regen100/cmake-language-server/issues/108

-- These generally follow the languages.toml file I've set up for Helix, and are meant to run
-- on the same system.
vim.lsp.enable({ 'bashls', 'clangd', 'eslint', 'neocmake', 'cssls', 'fish_lsp', 'gopls', 'html', 'jsonls', 'lua_ls',
	'marksman',
	'ruff',
	'tombi',
	'yamlls' })

vim.lsp.codelens.enable(true)

require('lualine').setup()

vim.cmd.colorscheme "catppuccin-macchiato"

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
		Lua = { diagnostics = { globals = { 'MiniExtra', 'MiniFiles', 'MiniPick' } } },
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

-- mini.clue from the README
local miniclue = require('mini.clue')
miniclue.setup({
	triggers = {
		-- Leader triggers
		{ mode = { 'n', 'x' }, keys = '<Leader>' },

		-- `[` and `]` keys
		{ mode = 'n',          keys = '[' },
		{ mode = 'n',          keys = ']' },

		-- Built-in completion
		{ mode = 'i',          keys = '<C-x>' },

		-- `g` key
		{ mode = { 'n', 'x' }, keys = 'g' },

		-- Marks
		{ mode = { 'n', 'x' }, keys = "'" },
		{ mode = { 'n', 'x' }, keys = '`' },

		-- Registers
		{ mode = { 'n', 'x' }, keys = '"' },
		{ mode = { 'i', 'c' }, keys = '<C-r>' },

		-- Window commands
		{ mode = 'n',          keys = '<C-w>' },

		-- `z` key
		{ mode = { 'n', 'x' }, keys = 'z' },

		-- mini.basics. This wasn't in the copypasta?
		{ mode = { 'n', 'x' }, keys = '\\' },
	},

	clues = {
		-- Enhance this by adding descriptions for <Leader> mapping groups
		miniclue.gen_clues.square_brackets(),
		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows(),
		miniclue.gen_clues.z(),
	},
})
