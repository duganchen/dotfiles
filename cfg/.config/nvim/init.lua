require("config.lazy")
require('lazy').setup({
  	'nvim-treesitter/nvim-treesitter',
  	lazy = false,
	build = ':TSUpdate'
})
require("catppuccin").setup({
	transparent_background = true
})
vim.cmd.colorscheme("catppuccin-macchiato")

