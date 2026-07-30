-- Conform. Just a copy and paste from Kickstart.
-- [[ Formatting ]]
require('conform').setup {
	formatters = {
		par = { command = 'par' },
		fmt = { command = 'fmt' }
	},
	notify_on_error = false,
	format_on_save = function(bufnr)
		-- Disable with a global or buffer-local variable
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end

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
		sh = { 'shfmt' },
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

-- And now I need for legacy (as opposed to greenfield) code:

-- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md
-- https://github.com/stevearc/conform.nvim/issues/192

vim.keymap.set('n', '<leader>ctf',
	function()
		if vim.b.disable_autoformat then
			vim.b.disable_autoformat = false
			vim.notify 'Enabled autoformat for current buffer'
		else
			vim.b.disable_autoformat = true
			vim.notify 'Disabled autoformat for current buffer'
		end
	end,
	{ desc = '[c]onform: buffer [toggle] [f]format' }
)


vim.keymap.set('n', '<leader>ctF',
	function()
		if vim.g.disable_autoformat then
			vim.g.disable_autoformat = false
			vim.notify 'Enabled autoformat globally'
		else
			vim.g.disable_autoformat = true
			vim.notify 'Disabled autoformat globally'
		end
	end,
	{ desc = '[c]onform: global [t]oggle [F]format:' }
)

-- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#format-command
-- A side effect of having space as the leader key is that you can't use it to invoke commands
-- on visual selections. So the following is out:
-- https://github.com/stevearc/conform.nvim/issues/40
vim.api.nvim_create_user_command("Format", function(args)
	local range = nil
	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end
	require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })
