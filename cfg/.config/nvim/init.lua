require("config.lazy")
require('lazy').setup("plugins", {
  	'nvim-treesitter/nvim-treesitter',
  	lazy = false,
	build = ':TSUpdate'
})
require("catppuccin").setup({
	transparent_background = true
})
vim.cmd.colorscheme("catppuccin-macchiato")

