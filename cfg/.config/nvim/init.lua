-- Note: To clean out unused packages, do:
-- :lua vim.pack.update(nil, { offline = true })
-- "gra" on (not active) packages
-- https://www.reddit.com/r/neovim/comments/1r92p2y/comment/o69dr8l/

-- This was a good package management primer
-- https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack.html

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
require('mini.sessions').setup()
require('mini.trailspace').setup()
require('mini.visits').setup()

-- See: https://www.reddit.com/r/neovim/comments/zy5s0l/you_dont_need_vimrooter_usually_or_how_to_set_up/
require('mini.misc').setup()
MiniMisc.setup_auto_root()
MiniMisc.setup_restore_cursor()

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

vim.o.relativenumber = true

-- https://www.reddit.com/r/neovim/comments/1jmqd7t/sorry_ufo_these_7_lines_replaced_you/
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldmethod = 'indent'
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
