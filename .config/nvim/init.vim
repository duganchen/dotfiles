call plug#begin('~/.config/nvim/plugged')
Plug 'freeo/vim-kalisi'
Plug 'bling/vim-airline'
Plug 'kien/ctrlp.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/syntastic'
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

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_enable_signs = 1

let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']']]

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

let g:airline_powerline_fonts = 1

syntax enable
colorscheme kalisi
let g:airline_theme='kalisi'

set background=dark
set wildmenu
set wildignore=*.pyc,*.swp,*.o

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

augroup initialization
	autocmd!
	" http://vim.wikia.com/wiki/Remove_unwanted_spaces
	autocmd BufWritePre * :%s/\s\+$//e
	autocmd FileType python RainbowParentheses
	autocmd FileType coffee,haskell,html,javascript,python,ruby setlocal expandtab
	autocmd FileType text setlocal colorcolumn=73 ignorecase noexpandtab textwidth=72
	autocmd FileType c,cpp,cs,java,objc,php setlocal cindent
	autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
augroup END

nnoremap <silent> <C-d> :lclose<CR>:bdelete<CR>
cabbrev <silent> bd <C-r>=(getcmdtype()==#':' && getcmdpos()==1 ? 'lclose\|bdelete' : 'bd')<CR>
