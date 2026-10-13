-- Use case is life times in Rust. I thought a key sequence to toggle MiniPairs was the best way to
-- handle it.

-- Based on the recipe to toggle Conform's auto-formatting, of course.

vim.keymap.set('n', '<leader>cp',
	function()
		if vim.b.minipairs_disable then
			vim.b.minipairs_disable = false
			vim.notify 'Enabled autopair for current buffer'
		else
			vim.b.minipairs_disable = true
			vim.notify 'Disabled autopair for current buffer'
		end
	end,
	{ desc = 'auto[p]air buffer toggle' }
)


vim.keymap.set('n', '<leader>cP',
	function()
		if vim.g.minipairs_disable then
			vim.g.minipairs_disable = false
			vim.notify 'Enabled autopair globally'
		else
			vim.g.minipairs_disable = true
			vim.notify 'Disabled autopair globally'
		end
	end,
	{ desc = 'auto[P]air global toggle' }
)
