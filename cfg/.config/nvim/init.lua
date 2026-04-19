vim.pack.add { { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
{ src = 'https://github.com/neovim/nvim-lspconfig' },}
require('catppuccin').setup({transparent_background = true})
vim.cmd.colorscheme "catppuccin-macchiato"

vim.o.autocomplete = true

vim.lsp.enable('bashls')
