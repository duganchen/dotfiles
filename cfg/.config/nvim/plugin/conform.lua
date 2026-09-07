-- Conform. This started as a copy-and-paste from Kickstart.
-- Formatting is changed to on-demand (a necessity when working on another person's project)
-- [[ Formatting ]]
require('conform').setup {
	formatters = {
		par = { command = 'par' },
		fmt = { command = 'fmt' }
	},
	notify_on_error = false,
	format_on_save = function(bufnr)
		if vim.g.enable_autoformat or vim.b[bufnr].enable_autoformat then
			-- You can specify filetypes to autoformat on save here:
			local enabled_filetypes = {
				c = true,
				css = true,
				cmake = true,
				cpp = true,
				fish = true,
				go = true,
				json = true,
				html = true,
				lua = true,
				markdown = true,
				python = true,
				sh = true,
				toml = true,
				typescript = true,
				yaml = true,
			}
			if enabled_filetypes[vim.bo[bufnr].filetype] then
				return { timeout_ms = 500, lsp_format = 'fallback' }
			else
				return nil
			end
		end
	end,
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


-- Note that my default is to have auto-format off. I think toggling it on with
-- cF is a good balance.
-- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md
-- https://github.com/stevearc/conform.nvim/issues/192

vim.keymap.set('n', '<leader>cf',
	function()
		if vim.b.en_autoformat then
			vim.b.enable_autoformat = false
			vim.notify 'Disabled autoformat for current buffer'
		else
			vim.b.enable_autoformat = true
			vim.notify 'Enabled autoformat for current buffer'
		end
	end,
	{ desc = 'auto[f]format buffer toggle' }
)


vim.keymap.set('n', '<leader>cF',
	function()
		if vim.g.enable_autoformat then
			vim.g.enable_autoformat = false
			vim.notify 'Disabled autoformat globally'
		else
			vim.g.enable_autoformat = true
			vim.notify 'Enabled autoformat globally'
		end
	end,
	{ desc = 'auto[F]format global toggle' }
)
