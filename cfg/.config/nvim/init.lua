vim.pack.add { { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	'https://github.com/neovim/nvim-lspconfig',
	'git@github.com:tpope/vim-surround.git',
	'https://github.com/tpope/vim-unimpaired',
	'git@github.com:tpope/vim-repeat.git',
	'https://github.com/nvim-tree/nvim-web-devicons',
	'git@github.com:nvim-lualine/lualine.nvim.git',

}
require('catppuccin').setup({ transparent_background = true })

vim.cmd.colorscheme "catppuccin-macchiato"

vim.o.autocomplete = true
-- https://www.reddit.com/r/neovim/comments/1pd6pg8/comment/ns4yopi/
vim.o.complete = "o,.,w,b,u"
vim.o.completeopt = "fuzzy,menuone,noselect,popup"

-- AI copy and paste
vim.lsp.config['lua_ls'] = {
	cmd = { 'lua-language-server' },
	root_markers = { '.git', 'init.lua' },
}
vim.lsp.enable({ 'lua_ls', 'bashls' })

-- Copy and paste from here
-- Gets rid of 'undefined global vim'
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
vim.lsp.config('lua_ls', {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
					path ~= vim.fn.stdpath('config')
					and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using (most
				-- likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
				-- Tell the language server how to find Lua modules same way as Neovim
				-- (see `:h lua-module-load`)
				path = {
					'lua/?.lua',
					'lua/?/init.lua',
				},
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					-- Depending on the usage, you might want to add additional paths
					-- here.
					-- '${3rd}/luv/library',
					-- '${3rd}/busted/library',
				},
				-- Or pull in all of 'runtimepath'.
				-- NOTE: this is a lot slower and will cause issues when working on
				-- your own configuration.
				-- See https://github.com/neovim/nvim-lspconfig/issues/3189
				-- library = vim.api.nvim_get_runtime_file('', true),
			},
		})
	end,
	settings = {
		Lua = {},
	},
})

require('lualine').setup()
