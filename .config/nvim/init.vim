call plug#begin('~/.config/nvim/plugged')
Plug 'freeo/vim-kalisi'
Plug 'bling/vim-airline'
Plug 'kien/ctrlp.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'benekastah/neomake'
" Plug 'scrooloose/syntastic'
Plug 'dag/vim-fish'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'hynek/vim-python-pep8-indent'
Plug 'jmcantrell/vim-virtualenv'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/rainbow_parentheses.vim'
call plug#end()

" Don't show the YouCompleteMe preview window.
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']']]

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

let g:airline_powerline_fonts = 1

syntax enable
colorscheme kalisi
let g:airline_theme='kalisi'

set background=dark

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

augroup initialization
	autocmd!
	" http://vim.wikia.com/wiki/Remove_unwanted_spaces
	autocmd BufWritePre * :%s/\s\+$//e
	autocmd FileType python setlocal colorcolumn=80 errorformat='%f:%l:%c'
	autocmd BufWritePost * Neomake
	autocmd FileType python RainbowParentheses
	autocmd FileType python let makeprg='flake8 '.shellescape(expand('%'))
    	autocmd FileType python let errorformat = '%E%f:%l: could not compile,%-Z%p^,%E%f:%l:%c: %m,%E%f:%l: %m,%-G%.%#'
	autocmd FileType coffee,haskell,html,javascript,python,ruby setlocal expandtab
	autocmd FileType text setlocal colorcolumn=73 ignorecase noexpandtab textwidth=72
	autocmd FileType c,cpp,cs,java,objc,php setlocal cindent
augroup END

" https://github.com/neovim/neovim/issues/2017
set timeout
set timeoutlen=750
set ttimeoutlen=250

"NeoVim handles ESC keys as alt+key, set this to solve the problem
set ttimeout
set ttimeoutlen=0

