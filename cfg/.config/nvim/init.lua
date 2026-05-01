vim.pack.add { { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	'https://github.com/neovim/nvim-lspconfig',
	'git@github.com:tpope/vim-surround.git',
	'https://github.com/tpope/vim-unimpaired',
	'git@github.com:tpope/vim-sleuth.git',
	'git@github.com:tpope/vim-repeat.git',
	'https://github.com/nvim-tree/nvim-web-devicons',
	'git@github.com:nvim-lualine/lualine.nvim.git',
	-- It's too early to care that this is "archived."
	'git@github.com:nvim-treesitter/nvim-treesitter.git',
	'git@github.com:nvim-telescope/telescope.nvim.git',
	-- for neocmake
	'git@github.com:L3MON4D3/LuaSnip.git',
	'git@github.com:hjson/vim-hjson.git'

}
require('catppuccin').setup({ transparent_background = true })

require('nvim-treesitter').install({ 'bash', 'c', 'cpp', 'cmake', 'css', 'fish', 'go', 'hjson', 'html', 'javascript',
	'json', 'lua',
	'markdown',
	'python', 'toml',
	'yaml' })

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
vim.o.number = true
vim.o.relativenumber = true
vim.opt.smartindent = true
vim.opt.autoindent = true

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
