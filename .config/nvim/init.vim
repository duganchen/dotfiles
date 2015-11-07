call plug#begin('~/.config/nvim/plugged')
Plug 'freeo/vim-kalisi'
Plug 'bling/vim-airline'
Plug 'kien/ctrlp.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/syntastic'
Plug 'luochen1990/rainbow'
Plug 'dag/vim-fish'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'lilydjwg/colorizer'
Plug 'hynek/vim-python-pep8-indent'
Plug 'jmcantrell/vim-virtualenv'
Plug 'airblade/vim-gitgutter'
call plug#end()

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Don't show the YouCompleteMe preview window.
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_enable_signs = 1

let g:rainbow_active = 1


syntax enable
set bg=dark
set t_Co=256
colorscheme kalisi
