local lspconfig = require('lspconfig')
local completion = require('completion')
local lsp_status = require('lsp-status')

lsp_status.register_progress()

local on_attach = function(client)
	completion.on_attach()
	lsp_status.on_attach(client)
end

-- LspInstall sumneko_lua
lspconfig.sumneko_lua.setup({on_attach=on_attach})

-- LspInstall vimls
lspconfig.vimls.setup({on_attach=on_attach})

lspconfig.clangd.setup({on_attach=on_attach})

require'nvim-treesitter.configs'.setup {
	ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	highlight = {
		enable = true,              -- false will disable the whole extension
	},
}
