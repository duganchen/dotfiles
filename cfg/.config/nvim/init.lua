-- Note: To clean out unused packages, do:
-- :lua vim.pack.update(nil, { offline = true })
-- "gra" on (not active) packages
-- https://www.reddit.com/r/neovim/comments/1r92p2y/comment/o69dr8l/

-- This was a good package management primer
-- https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack.html

-- Just ssh-add your public key to the ssh agent agent before updating packages. It's
-- the best way I could find to deal with the askpass/"Allow Inhibiting Shortcuts"
-- spam (one pair for each plugin, all at the same time!) on GNOME.

vim.pack.add({
	{ src = "git@github.com:catppuccin/nvim",         name = "catppuccin" },
	"git@github.com:neovim/nvim-lspconfig.git",
	-- still want this Tim Pope plugin
	"git@github.com:tpope/vim-sleuth.git",
	"git@github.com:nvim-treesitter/nvim-treesitter.git",
	"git@github.com:hjson/vim-hjson.git",
	"https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git",
	-- Yeah lets's just do all of these
	{ src = "git@github.com:nvim-mini/mini.nvim.git", version = "stable" },
	"git@github.com:rafamadriz/friendly-snippets.git",
	"git@github.com:mason-org/mason.nvim.git",
	"git@github.com:mason-org/mason-lspconfig.nvim.git",
	"git@github.com:folke/lazydev.nvim.git",
	"git@github.com:stevearc/conform.nvim.git",
	"git@github.com:nvim-treesitter/nvim-treesitter-textobjects.git",
	-- This will eventually be able to go:
	-- https://www.reddit.com/r/neovim/comments/1w4ie5n/markdown_images_in_neovim_013_no_plugin_needed/
	-- https://www.reddit.com/r/neovim/comments/1w2rjor/vimuiimg_neovim_013s_new_api_for_images/
	-- Of course, I'll need Kitty protocol support
	-- https://github.com/neovim/neovim/pull/39773
	"git@github.com:3rd/image.nvim.git",
})

-- These work well with Ubuntu's default purple terminal:
-- https://github.com/rose-pine/neovim
-- https://github.com/edeneast/nightfox.nvim

-- From Kickstart
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name = ev.data.spec.name
		local kind = ev.data.kind
		if kind ~= "install" and kind ~= "update" then
			return
		end

		if name == "nvim-treesitter" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
			return
		end
	end,
})

require("catppuccin").setup({ transparent_background = true })

require("mini.ai").setup()
require("mini.basics").setup()

require("mini.pairs").setup()
require("mini.surround").setup()

require("mini.completion").setup()
require("mini.pick").setup()
require("mini.extra").setup()
-- Think about replacing as of 0.13:
-- https://www.reddit.com/r/neovim/comments/1uh24id/new_builtin_directory_viewer/
require("mini.files").setup()
require("mini.hipatterns").setup()

-- I like Lualine, fugitive, fidget, etc, but whatever. Let's go with this kit.
require("mini.notify").setup()
require("mini.statusline").setup()
require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()
require("mini.git").setup()
-- https://www.reddit.com/r/neovim/comments/1bq0cxy/minidiff_work_with_diff_hunks_interactively/
require("mini.diff").setup()
require("mini.cmdline").setup()
require("mini.sessions").setup()
local starter = require("mini.starter")
starter.setup({
	items = {
		starter.sections.pick(),
		starter.sections.recent_files(),
		starter.sections.sessions(),
		starter.sections.builtin_actions()
	},
})
require("mini.trailspace").setup()
require("mini.visits").setup()

-- This works well. I'm also aware of this, but I don't feel like trying it right now:
-- https://github.com/hakonharnes/img-clip.nvim
require("image").setup()

-- See: https://www.reddit.com/r/neovim/comments/zy5s0l/you_dont_need_vimrooter_usually_or_how_to_set_up/
require("mini.misc").setup()
MiniMisc.setup_auto_root()
MiniMisc.setup_restore_cursor()

-- Copy and paste from the mini.snippets README
local gen_loader = require("mini.snippets").gen_loader
require("mini.snippets").setup({
	snippets = {
		-- Load custom file with global snippets first (adjust for Windows)
		gen_loader.from_file("~/.config/nvim/snippets/global.json"),

		-- Load snippets based on current language by reading files from
		-- "snippets/" subdirectories from 'runtimepath' directories.
		gen_loader.from_lang(),
	},
})

require("lazydev").setup()
require("mason").setup()

-- not using cmake-language-server because of this:
-- https://github.com/regen100/cmake-language-server/issues/108
-- Apart from that, this started from Helix's default list.
require("mason-lspconfig").setup({
	ensure_installed = {
		"bashls",
		"clangd",
		"eslint",
		"neocmake",
		"cssls",
		"fish_lsp",
		"gopls",
		"html",
		"jsonls",
		"lua_ls",
		"marksman",
		"pyrefly",
		"rust_analyzer",
		"tombi",
		"yamlls",
	}
})

-- Note that mini.basics has set the leader key to space
-- Mostly using Kickstart's setup, which starts finders with "<space>" s.
-- No jumplist search though. Telescope has it, but AFAIK mini.pick doesn't

-- These match LazyVim's bindings

vim.keymap.set("n", "<leader>,", MiniPick.builtin.buffers, { desc = "[S]earch [B]uffers" })
vim.keymap.set("n", "<leader>e", MiniFiles.open, { desc = "[e]xplorer" })

-- I don't see a way to get MiniPick.files to open from a specific directory (like the lsp root).
-- So just open it from cwd.

-- https://github.com/nvim-mini/mini.nvim/issues/830

require('mini.pick').setup()
MiniPick.registry.files_fd = function()
	local command = { 'fd', '--type=f', '--color=never', '--hidden', '-E', '.git' }
	local show_with_icons = function(buf_id, items, query)
		return MiniPick.default_show(buf_id, items, query, { show_icons = true })
	end
	local source = { name = 'Files fd', show = show_with_icons }
	return MiniPick.builtin.cli({ command = command }, { source = source })
end

vim.keymap.set("n", "<leader>ff", function()
	MiniPick.registry.files_fd()
end, { desc = "[f]ind [f]iles (fd)" })

vim.keymap.set("n", "<leader>fg", function()
	MiniPick.builtin.files({ tool = 'git' })
end, { desc = "[f]ind files (git)" })

-- Or <leader>/
vim.keymap.set("n", "<leader>/", MiniPick.builtin.grep_live, { desc = "Live Grep" })

-- In LazyVim this is a plugin named "trouble" or something like it.
vim.keymap.set("n", "<leader>x", MiniExtra.pickers.diagnostic, { desc = "Search diagnostics" })

-- from LazyVim
function WorkspaceSymbolSearch()
	MiniExtra.pickers.lsp({ scope = "workspace_symbol_live" })
end

vim.keymap.set("n", "<leader>sS", WorkspaceSymbolSearch, { desc = "[S]earch [S]ymbols (workspace)" })

function DocumentSymbolSearch()
	MiniExtra.pickers.lsp({ scope = "document_symbol" })
end

vim.keymap.set("n", "<leader>ss", DocumentSymbolSearch, { desc = "[S]search [s]ymbols (document)" })

vim.keymap.set("n", "<leader>sm", MiniExtra.pickers.marks, { desc = "[S]earch [m]arks" })
vim.cmd.colorscheme("catppuccin-macchiato")

vim.o.relativenumber = true
vim.o.ignorecase = false

-- https://www.reddit.com/r/neovim/comments/1jmqd7t/sorry_ufo_these_7_lines_replaced_you/
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldmethod = "indent"
vim.o.foldtext = ""
vim.opt.foldcolumn = "1"

vim.opt.timeoutlen = 300

-- https://www.lazyvim.org/configuration/general
vim.opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}

-- More cargo-culting from Kickstart
vim.g.have_nerd_font = true
vim.loader.enable()
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Symbol jumps are Ctrl-] and Ctrl-^
-- Format (with conform) is gq
-- Toggling auto-format is added by conform.lua
-- See also :h lsp-defaults. gra, grn, etc.

vim.keymap.set("n", "<leader>ch", function()
	-- This is from Google AI, although the source it gave was this:
	-- https://youtu.be/Qn6YkDk8FoI?si=56q19euSqHBE3FfG
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
	-- Or "K" (shift-k) with the cursor over an identifier.
end, { desc = "Toggle inlay [h]ints" })

vim.keymap.set("n", "<leader>cg", MiniDiff.toggle_overlay, { desc = "Toggle [g]it overlay" })
