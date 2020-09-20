local vim = require('vim')
local nvim_lsp = require('nvim_lsp')
local completion = require('completion')
local diagnostic = require('diagnostic')
local lsp_status = require('lsp-status')

lsp_status.register_progress()

nvim_lsp.config.capabilities = vim.tbl_extend('keep', nvim_lsp.config.capabilities or {}, lsp_status.capabilities)

local on_attach = function(client)
	completion.on_attach()
	diagnostic.on_attach()
	lsp_status.on_attach(client)
end

nvim_lsp.sumneko_lua.setup({on_attach=on_attach})
nvim_lsp.clangd.setup({on_attach=on_attach})
nvim_lsp.vimls.setup({on_attach=on_attach})

