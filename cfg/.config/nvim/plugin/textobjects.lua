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
