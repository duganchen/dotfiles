-- Note: To clean out unused packages, do:
-- :lua vim.pack.update(nil, { offline = true })
-- "gra" on (not active) packages
-- https://www.reddit.com/r/neovim/comments/1r92p2y/comment/o69dr8l/

vim.pack.add { { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	'https://github.com/neovim/nvim-lspconfig',
	-- still want this Tim Pope plugin
	'git@github.com:tpope/vim-sleuth.git',
	-- It's too early to care that this is "archived."
	'git@github.com:nvim-treesitter/nvim-treesitter.git',
	'git@github.com:hjson/vim-hjson.git',
	'https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git',
	-- Yeah lets's just do all of these
	{ src = 'git@github.com:nvim-mini/mini.nvim.git', version = 'stable' },
	'git@github.com:rafamadriz/friendly-snippets.git',
	'git@github.com:mason-org/mason.nvim.git',
	'git@github.com:folke/lazydev.nvim.git',
	'git@github.com:stevearc/conform.nvim.git',
	'git@github.com:nvim-treesitter/nvim-treesitter-textobjects.git',
}


-- From Kickstart
vim.api.nvim_create_autocmd('PackChanged', {
	callback = function(ev)
		local name = ev.data.spec.name
		local kind = ev.data.kind
		if kind ~= 'install' and kind ~= 'update' then return end


		if name == 'nvim-treesitter' then
			if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
			vim.cmd 'TSUpdate'
			return
		end
	end,
})

require('catppuccin').setup({ transparent_background = true })

-- Kickstart stuff
require('nvim-treesitter').install({ 'bash', 'c', 'cpp', 'cmake', 'css', 'fish', 'go', 'hjson', 'html', 'javascript',
	'json', 'lua',
	'markdown',
	'python', 'toml',
	'yaml' })

do
	-- [[ Configure Treesitter ]]
	--  Used to highlight, edit, and navigate code
	--
	--  See `:help nvim-treesitter-intro`

	-- NOTE: You can also specify a branch or a specific commit

	-- Ensure basic parsers are installed
	local parsers = { 'bash', 'c', 'cpp', 'cmake', 'css', 'fish', 'go', 'hjson', 'html', 'javascript',
		'json', 'lua',
		'markdown',
		'python', 'toml',
		'yaml' }
	require('nvim-treesitter').install(parsers)

	---@param buf integer
	---@param language string
	local function treesitter_try_attach(buf, language)
		-- Check if a parser exists and load it
		if not vim.treesitter.language.add(language) then return end
		-- Enable syntax highlighting and other treesitter features
		vim.treesitter.start(buf, language)

		-- Check if treesitter indentation is available for this language, and if so enable it
		-- in case there is no indent query, the indentexpr will fallback to the vim's built in one
		local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

		-- Enable treesitter based indentation
		if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
	end

	local available_parsers = require('nvim-treesitter').get_available()
	vim.api.nvim_create_autocmd('FileType', {
		callback = function(args)
			local buf, filetype = args.buf, args.match

			local language = vim.treesitter.language.get_lang(filetype)
			if not language then return end

			local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

			if vim.tbl_contains(installed_parsers, language) then
				-- Enable the parser if it is already installed
				treesitter_try_attach(buf, language)
			elseif vim.tbl_contains(available_parsers, language) then
				-- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
				require('nvim-treesitter').install(language):await(function()
					treesitter_try_attach(buf,
						language)
				end)
			else
				-- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
				treesitter_try_attach(buf, language)
			end
		end,
	})
end

require('mini.basics').setup()
require('mini.surround').setup()
require('mini.completion').setup()
require('mini.pick').setup()
require('mini.extra').setup()
require('mini.pairs').setup()

-- I like Lualine, fugitive, fidget, etc, but whatever. Let's go with this kit.
require('mini.notify').setup()
require('mini.statusline').setup()
require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()
require('mini.git').setup()
require('mini.diff').setup()
require('mini.cmdline').setup()
require('mini.starter').setup()

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

require('lazydev').setup()

-- mini.clue is set up below

require('mason').setup()

-- Note that mini.basics has set the leader key to space
-- Mostly using Kickstart's setup, which starts finders with "<space>" s.
-- No jumplist search though. Telescope has it, but AFAIK mini.pick doesn't
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

vim.cmd.colorscheme "catppuccin-macchiato"

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.vim.lsp.foldexpr()"
-- -- start with folds open
-- vim.opt.foldlevel = 99
-- -- Still mastering this, but this makes it work more predictably to me
-- vim.opt.foldcolumn = "1"
-- -- The \r toggle still works. Just sets a different default.
vim.o.relativenumber = true

-- https://www.reddit.com/r/neovim/comments/1jmqd7t/sorry_ufo_these_7_lines_replaced_you/
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()"
vim.o.foldtext = ""
vim.opt.foldcolumn = "1"

-- https://www.lazyvim.org/configuration/general
vim.opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}

-- More cargo-culting from Quickstart
vim.g.have_nerd_font = true
vim.loader.enable()
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

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


		-- And the bracketed movement keys
		{ mode = 'n', keys = ']' },
		{ mode = 'x', keys = ']' },
		{ mode = 'n', keys = '[' },
		{ mode = 'x', keys = '[' },
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

-- Conform. Just a copy and paste from Kickstart.
do
	-- [[ Formatting ]]
	require('conform').setup {
		formatters = {
			par = { command = 'par' },
			fmt = { command = 'fmt' }
		},
		notify_on_error = false,
		format_on_save = function(bufnr)
			-- You can specify filetypes to autoformat on save here:
			local enabled_filetypes = {
				lua = true,
				python = true,
				markdown = true,
				text = true,
				c = true
			}
			if enabled_filetypes[vim.bo[bufnr].filetype] then
				return { timeout_ms = 500 }
			else
				return nil
			end
		end,
		default_format_opts = {
			lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
		},
		-- You can also specify external formatters in here.
		formatters_by_ft = {
			markdown = { 'prettier' },
			text = { 'par', 'fmt', stop_after_first = true }
			-- rust = { 'rustfmt' },
			-- Conform can also run multiple formatters sequentially
			-- python = { "isort", "black" },
			--
			-- You can use 'stop_after_first' to run the first available formatter from the list
			-- javascript = { "prettierd", "prettier", stop_after_first = true },
		},
	}

	vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end,
		{ desc = '[F]ormat buffer' })
end

-- Add function/class/parameter text objects and movement

-- I do want mini.bracketed, but I also want textobject movements. Exact mappings are
-- neovim's.
-- https://www.lazyvim.org/plugins/treesitter#nvim-treesitter-textobjects

-- I couldn't get conditional/loop/block text objects to work. Honestly, after setting all this up,
-- I realized that the traditional way to deal with all of these was with folds.

require('mini.bracketed').setup({
	-- f/F is now function call
	file = { suffix = '' },
	-- c/C is now class
	comment = { suffix = '' },
})

require('nvim-treesitter-textobjects').setup({ move = { set_jumps = true } })

local ts_move = require("nvim-treesitter-textobjects.move")
-- Function
vim.keymap.set({ "n", "x", "o" }, "]f", function()
	ts_move.goto_next_start("@function.outer", "textobjects")
end, { desc = "Function forward start" })

vim.keymap.set({ "n", "x", "o" }, "]F", function()
	ts_move.goto_next_end("@function.outer", "textobjects")
end, { desc = "Fucntion forward end" })

vim.keymap.set({ "n", "x", "o" }, "[f", function()
	ts_move.goto_previous_start("@function.outer", "textobjects")
end, { desc = "Function backward start" })

vim.keymap.set({ "n", "x", "o" }, "[F", function()
	ts_move.goto_previous_end("@function.outer", "textobjects")
end, { desc = "Function backward end" })

-- Class
vim.keymap.set({ "n", "x", "o" }, "]c", function()
	ts_move.goto_next_start("@class.outer", "textobjects")
end, { desc = "Class forward start" })

vim.keymap.set({ "n", "x", "o" }, "]C", function()
	ts_move.goto_next_end("@class.outer", "textobjects")
end, { desc = "Class forward end" })

vim.keymap.set({ "n", "x", "o" }, "[c", function()
	ts_move.goto_previous_start("@class.outer", "textobjects")
end, { desc = "Class backward start" })

vim.keymap.set({ "n", "x", "o" }, "[C", function()
	ts_move.goto_previous_end("@class.outer", "textobjects")
end, { desc = "Class backward end" })

-- Parameter
vim.keymap.set({ "n", "x", "o" }, "]a", function()
	ts_move.goto_next_start("@parameter.inner", "textobjects")
end, { desc = "Parameter forward start" })

vim.keymap.set({ "n", "x", "o" }, "]A", function()
	ts_move.goto_next_end("@parameter.inner", "textobjects")
end, { desc = "Parameter forward end" })

vim.keymap.set({ "n", "x", "o" }, "[a", function()
	ts_move.goto_previous_start("@parameter.inner", "textobjects")
end, { desc = "Parameter backward start" })

vim.keymap.set({ "n", "x", "o" }, "[A", function()
	ts_move.goto_previous_end("@parameter.inner", "textobjects")
end, { desc = "Parameter backward end" })

local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

-- vim way: ; goes to the direction you were moving.
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

-- mini.ai too.
-- Inspired by Lazyvim
-- https://www.reddit.com/r/neovim/comments/136vj6x/whats_the_difference_between_these_two_miniai/
-- https://www.lazyvim.org/plugins/coding#miniai
local mini_ai = require('mini.ai')
mini_ai.setup({
	n_lines = 500,

	custom_textobjects = {
		f = mini_ai.gen_spec.treesitter({
			a = '@function.outer',
			i = '@function.inner',
		}),

		c = mini_ai.gen_spec.treesitter({
			a = '@class.outer',
			i = '@class.inner',
		}),

		a = mini_ai.gen_spec.treesitter({
			a = '@parameter.outer',
			i = '@parameter.inner',
		}),
	},
})
