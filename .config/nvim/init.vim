call plug#begin('~/.local/share/nvim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'arcticicestudio/nord-vim'
call plug#end()

lua require "lsp"

" For nvim-completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set completeopt=menuone,noinsert,noselect
set shortmess+=c

" For nvim-diagnostics
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_virtual_text_prefix = ' '

" From here 
" https://www.reddit.com/r/neovim/comments/gu08zv/nvimlsp_statusline/fsgcam4
function! StatuslineLsp() abort
return luaeval("require('lsp-status').status()")
endfunction
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set statusline+=%{StatuslineLsp()}

augroup lsp
autocmd BufWritePre *.cpp,*.lua,*.vim lua vim.lsp.buf.formatting_sync(nil, 1000)
augroup END

set termguicolors
let g:nord_italic = 1
let g:nord_bold = 1
let g:nord_underline = 1
let g:nord_italic_comments = 1
colorscheme nord

