local nvim_lsp = require('nvim_lsp')
local completion = require('completion')
local diagnostic = require('diagnostic')
local lsp_status = require('lsp-status')

lsp_status.register_progress()

local on_attach = function(client)
	completion.on_attach()
	diagnostic.on_attach()
	lsp_status.on_attach(client)
end

-- LspInstall sumneko_lua
nvim_lsp.sumneko_lua.setup({on_attach=on_attach})

-- LspInstall vimls
nvim_lsp.vimls.setup({on_attach=on_attach})

nvim_lsp.clangd.setup({on_attach=on_attach})

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = true,              -- false will disable the whole extension
	    disable = { "c", "rust" },  -- list of language that will be disabled
	      },
	      }
