vim.pack.add { { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
{ src = 'https://github.com/neovim/nvim-lspconfig' },
{ src = 'https://github.com/arborist-ts/arborist.nvim'}
}
require('catppuccin').setup({transparent_background = true})
require('arborist').setup()
vim.cmd.colorscheme "catppuccin-macchiato"

vim.o.autocomplete = true

vim.lsp.enable('bashls')
