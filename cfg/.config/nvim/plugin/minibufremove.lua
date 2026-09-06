require('mini.bufremove').setup()

-- Reproduce Minimax's buffer-closing commands
vim.keymap.set('n', '<leader>bd', MiniBufremove.delete, { desc = '[b]uffer [d]elete' })
vim.keymap.set('n', '<leader>bD', function()
	MiniBufremove.delete(0, true)
end, { desc = '[b]uffer [D]elete!' })
vim.keymap.set('n', '<leader>bw', MiniBufremove.wipeout, { desc = '[b]uffer [w]ipeout' })
vim.keymap.set('n', '<leader>bW', function()
	MiniBufremove.wipeout(0, true)
end, { desc = '[b]uffer [W]ipeout!' })
