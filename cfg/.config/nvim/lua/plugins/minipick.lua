-- I don't see a way to get MiniPick.files to open from a specific directory (like the lsp root).
-- So just open it from cwd.

-- https://github.com/nvim-mini/mini.nvim/issues/830

MiniPick.registry.files_fd = function()
	local command = { 'fd', '--type=f', '--color=never', '--follow', '--hidden', '-E', '.git' }
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
