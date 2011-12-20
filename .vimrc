filetype plugin indent on
syntax enable

set shiftwidth=4 tabstop=4 softtabstop=4 showcmd hlsearch incsearch smartcase autoindent ruler showmode visualbell ruler nobackup textwidth=0 wrap noignorecase smarttab spelllang=en_ca number omnifunc=syntaxcomplete#Complete showmatch title noerrorbells noswapfile t_Co=256 mouse=a nocompatible wildmenu ttyfast encoding=utf-8 laststatus=2

autocmd FileType haskell setlocal expandtab 
autocmd FileType python setlocal expandtab list colorcolumn=80 encoding=latin1 foldmethod=indent foldlevel=99
autocmd FileType text setlocal spell ignorecase noexpandtab textwidth=72 colorcolumn=73
autocmd Filetype c,cpp,cs,java,objc,php setlocal cindent
autocmd Filetype javascript setlocal foldlevel=0

let g:neocomplcache_enable_at_startup = 1
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

set statusline=%n\ %f\ %y\ %R\ %m\ %#warningmsg#%{SyntasticStatuslineFlag()}%*\ %{fugitive#statusline()}%=%l/%L,%c

color inkpot
