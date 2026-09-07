-- Conform. This started as a copy-and-paste from Kickstart.
-- Formatting is changed to on-demand (a necessity when working on another person's project)
-- [[ Formatting ]]
require('conform').setup {
	formatters = {
		par = { command = 'par' },
		fmt = { command = 'fmt' }
	},
	notify_on_error = false,
	default_format_opts = {
		lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
	},
	formatters_by_ft = {

		c        = { 'clang-format' },
		cpp      = { 'clang-format' },
		fish     = { 'fish_indent' },
		go       = { 'gofmt' },
		markdown = { 'prettier' },
		python   = { 'ruff format' },
		sh       = { 'shfmt' },
		text     = { 'par', 'fmt', stop_after_first = true },
		yaml     = { 'prettier' }
		-- rust = { 'rustfmt' },
		-- Conform can also run multiple formatters sequentially
		-- python = { "isort", "black" },
		--
		-- You can use 'stop_after_first' to run the first available formatter from the list
		-- javascript = { "prettierd", "prettier", stop_after_first = true },
	},
}

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
