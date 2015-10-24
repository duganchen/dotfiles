set nocompatible              " be iMproved, required
filetype off                  " required
set shell=/bin/bash           " Needed to get vundle to work when you're not using BASH.

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-sensible'
Plugin 'airblade/vim-gitgutter'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
Bundle "andrwb/vim-lapis256"
Bundle "junegunn/seoul256.vim"
Bundle 'tpope/vim-fugitive'
Bundle 'luochen1990/rainbow'
Bundle 'dag/vim-fish'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'lilydjwg/colorizer'
Bundle 'jmcantrell/vim-virtualenv'
Bundle 'hynek/vim-python-pep8-indent'

call vundle#end()

filetype plugin indent on

" End of Vundle initialization code.:

set background=dark
set nobackup

" Tab stops are 4.
set shiftwidth=4
set softtabstop=4
set tabstop=4

set statusline+=%t " file basename"
set statusline+=\ %y
set statusline+=%h
set statusline+=%m
set statusline+=%r
set statusline+=%{fugitive#statusline()}
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%{virtualenv#statusline()}
set statusline+=%*
set statusline+=%=
set statusline+=BUF:\ %n
set statusline+=\ \|\ %l/%L\ (%P)
set statusline+=\ \|\ COL:\ %v

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

set t_Co=256
colorscheme lapis256

" Transparent background for the terminal vim.
highlight Normal cterm=NONE ctermbg=NONE

augroup initialization
	autocmd!
	" http://vim.wikia.com/wiki/Remove_unwanted_spaces
	autocmd BufWritePre * :%s/\s\+$//e
	autocmd FileType python setlocal colorcolumn=80
	autocmd FileType coffee,haskell,html,javascript,python,ruby setlocal expandtab
	autocmd FileType text setlocal colorcolumn=73 ignorecase noexpandtab textwidth=72
	autocmd FileType c,cpp,cs,java,objc,php setlocal cindent
augroup END
