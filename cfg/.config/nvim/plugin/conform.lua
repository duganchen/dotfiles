-- Conform. Just a copy and paste from Kickstart.
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
			text = true,
			toml = true,
			typescript = true,
			yaml = true,
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
		c = { 'clang-format' },
		cpp = { 'clang-format' },
		fish = { 'fish_indent' },
		go = { 'gofmt' },
		markdown = { 'prettier' },
		python = { 'ruff format' },
		sh = { 'shmt' },
		text = { 'par', 'fmt', stop_after_first = true },
		yaml = { 'prettier' }
		-- rust = { 'rustfmt' },
		-- Conform can also run multiple formatters sequentially
		-- python = { "isort", "black" },
		--
		-- You can use 'stop_after_first' to run the first available formatter from the list
		-- javascript = { "prettierd", "prettier", stop_after_first = true },
	},
}
