call plug#begin('~/.local/share/nvim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'justinmk/vim-dirvish'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'machakann/vim-highlightedyank'
Plug 'junegunn/vim-slash'
Plug 'tpope/vim-fugitive'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'bluz71/vim-moonfly-colors'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'tpope/vim-sleuth'
call plug#end()

" Don't mind if I steal a couple of lines from here:
" https://www.reddit.com/r/neovim/comments/3oeko4/post_your_fzfvim_configurations/cvworyj
nnoremap <silent> <leader>t :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>

lua require "treesitter"
lua require "lsp"

" For nvim-completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set completeopt=menuone,noinsert,noselect
set shortmess+=c

" For nvim-diagnostics
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_virtual_text_prefix = ' '

" Treesitter
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

augroup lsp
	" The formatting capabilities of the Typescript server are better off
	" not being used.
	" https://github.com/theia-ide/typescript-language-server/issues/10
	"
	" Leaving this out while I figure out why it's not working
	" autocmd BufWritePre *.cpp,*.vim,*.py,*.lua lua vim.lsp.buf.formatting_sync(nil, 1000)
augroup END

" From here 
" https://www.reddit.com/r/neovim/comments/gu08zv/nvimlsp_statusline/fsgcam4
function! StatuslineLsp() abort
	return luaeval("require('lsp-status').status()")
endfunction

set statusline=%f 
set statusline+=\ %{WebDevIconsGetFileTypeSymbol()}
set statusline+=\ %{WebDevIconsGetFileFormatSymbol()}    
set statusline+=\ %{fugitive#statusline()}
set statusline+=\ %{StatuslineLsp()}
set statusline+=\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %P%)


set termguicolors
" Please note that this needs a an opaque terminal set up with the moonfly
" colorscheme.
colorscheme moonfly
highlight HighlightedyankRegion cterm=reverse gui=reverse
