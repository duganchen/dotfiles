" Boilerplate to get vundle to work.

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'wincent/Command-T'
Bundle 'scrooloose/syntastic'
Bundle 'tomasr/molokai'
Bundle 'jmcantrell/vim-virtualenv'
Bundle 'tpope/vim-fugitive'
Bundle 'Valloric/YouCompleteMe'

" My stuff starts here

filetype plugin indent on
syntax enable

" http://vim.wikia.com/wiki/Remove_unwanted_spaces
autocmd BufWritePre * :%s/\s\+$//e

" We don't want the default filetype to be text.
autocmd BufEnter * if &filetype == "" | setlocal ft=unknown | endif

set autoindent encoding=utf-8 hlsearch incsearch laststatus=2 mouse=a nospell number nobackup nocompatible noerrorbells noignorecase noswapfile omnifunc=syntaxcomplete#Complete ruler smartcase shiftwidth=4 showcmd showmatch showmode softtabstop=4 smarttab t_Co=256 tabstop=4 textwidth=0 title ttyfast visualbell wildmenu wildignore+=*.pyc wrap

autocmd FileType html,markdown,plaintex,tex,text set spell spelllang=en_ca
autocmd FileType coffee,haskell,javascript,python,ruby setlocal expandtab
autocmd FileType python setlocal colorcolumn=80 foldlevel=99 foldmethod=indent
autocmd FileType text setlocal colorcolumn=73 ignorecase noexpandtab textwidth=72
autocmd FileType c,cpp,cs,java,objc,php setlocal cindent
autocmd FileType javascript setlocal foldlevel=0
autocmd FileType snippet setlocal noexpandtab nospell
autocmd BufReadPost fugitive://* set bufhidden=delete

let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

let g:syntastic_c_compiler = 'clang'
let g:syntastic_cpp_compiler = 'clang++'

" Syntastic assumes C++11 support.
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_cpp_config_file = '.syntastic_cpp_config'

let g:virtualenv_stl_format = '[%n]'

set statusline=%n\ %f\ %y\ %R\ %m\ %#warningmsg#%{SyntasticStatuslineFlag()}%*\ %{fugitive#statusline()}%{virtualenv#statusline()}%=%l/%L,%c

" set statusline=%n\ %f\ %y\ %R\ %m\ %#warningmsg#%{SyntasticStatuslineFlag()}%*\ %{fugitive#statusline()}%=%l/%L,%c

color molokai
