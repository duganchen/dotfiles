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
	'git@github.com:nvim-lualine/lualine.nvim.git',
	-- It's too early to care that this is "archived."
	'git@github.com:nvim-treesitter/nvim-treesitter.git',
	'git@github.com:nvim-lua/plenary.nvim.git',
	'git@github.com:hjson/vim-hjson.git',
	'https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git',
	-- Let's replace the standard Tim Pope plugins
	{ src = 'git@github.com:nvim-mini/mini.nvim.git', version = 'stable' },
	'git@github.com:rafamadriz/friendly-snippets.git',

	'git@github.com:mason-org/mason.nvim.git',

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
require('mini.icons').setup()
require('mini.completion').setup()
require('mini.pick').setup()
require('mini.bracketed').setup()
require('mini.extra').setup()
require('mini.pairs').setup()
require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()


-- See: https://www.reddit.com/r/neovim/comments/zy5s0l/you_dont_need_vimrooter_usually_or_how_to_set_up/
require('mini.misc').setup()
MiniMisc.setup_auto_root()


-- Copy and paste from the mini.snippets README
local gen_loader = require('mini.snippets').gen_loader
require('mini.snippets').setup({
	snippets = {
		-- Load custom file with global snippets first (adjust for Windows)
		gen_loader.from_file('~/.config/nvim/snippets/global.json'),

		-- Load snippets based on current language by reading files from
		-- "snippets/" subdirectories from 'runtimepath' directories.
		gen_loader.from_lang(),
	},
})

-- mini.clue is set up below

require('mason').setup()
require('mason-nvim-dap').setup()
require('nvim-dap-virtual-text').setup()

-- these are from LazyVim
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
vim.keymap.set('n', '<leader>e', MiniExtra.pickers.explorer, { desc = 'open the explorer picker' })
-- Or <leader>/
vim.keymap.set('n', '<leader>sg', MiniPick.builtin.grep_live, { desc = '[S]earch by [G]rep' })

-- from LazyVim
function WorkspaceSymbolSearch()
	MiniExtra.pickers.lsp({ scope = 'workspace_symbol_live' })
end

vim.keymap.set('n', '<leader>sS',
	WorkspaceSymbolSearch, { desc = '[S]earch [S]ymbols (workspace)' })

function DocumentSymbolSearch()
	MiniExtra.pickers.lsp({ scope = 'document_symbol' })
end

vim.keymap.set('n', '<leader>ss',
	DocumentSymbolSearch, { desc = '[S]search [s]ymbols (document)' })


vim.keymap.set('n', '<leader>sm', MiniExtra.pickers.marks, { desc = '[S]earch [m]arks' })

-- And you know you need this
-- Works fine in C++. Not so good with init.lua.
vim.keymap.set('n', '<leader>sd', MiniExtra.pickers.diagnostic, { desc = '[S]earch [d]iagnostics' })


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
-- The \r toggle still works. Just sets a different default.
vim.o.relativenumber = true

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
		Lua = { diagnostics = { globals = { 'MiniExtra', 'MiniMisc', 'MiniIcons', 'MiniPick' } } },
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
-- Note that this currently differs quite a bit between stable and main
local miniclue = require('mini.clue')
miniclue.setup({
	triggers = {
		-- Leader triggers
		{ mode = 'n', keys = '<Leader>' },
		{ mode = 'x', keys = '<Leader>' },

		-- Built-in completion
		{ mode = 'i', keys = '<C-x>' },

		-- `g` key
		{ mode = 'n', keys = 'g' },
		{ mode = 'x', keys = 'g' },

		-- Marks
		{ mode = 'n', keys = "'" },
		{ mode = 'n', keys = '`' },
		{ mode = 'x', keys = "'" },
		{ mode = 'x', keys = '`' },

		-- Registers
		{ mode = 'n', keys = '"' },
		{ mode = 'x', keys = '"' },
		{ mode = 'i', keys = '<C-r>' },
		{ mode = 'c', keys = '<C-r>' },

		-- Window commands
		{ mode = 'n', keys = '<C-w>' },

		-- `z` key
		{ mode = 'n', keys = 'z' },
		{ mode = 'x', keys = 'z' },


		-- `Miniclue backslash` key
		{ mode = 'n', keys = '\\' },
		{ mode = 'x', keys = '\\' },
	},

	clues = {
		-- Enhance this by adding descriptions for <Leader> mapping groups
		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows(),
		miniclue.gen_clues.z(),
	},
})
