" I use the following plugins:
"	* neocomplache
"	* syntastic
"	* fugitive
"	* command-t
"	* solarized color theme

filetype plugin indent on
syntax enable

set autoindent background=dark encoding=utf-8 hlsearch incsearch laststatus=2 mouse=a number nobackup nocompatible noerrorbells noignorecase noswapfile omnifunc=syntaxcomplete#Complete ruler smartcase shiftwidth=4 showcmd showmatch showmode softtabstop=4 smarttab spell spelllang=en_ca t_Co=256 tabstop=4 textwidth=0 title ttyfast visualbell wildmenu wrap 

autocmd FileType asm,c,cpp,cs,haskell,java,objc,phppython setlocal nospell
autocmd FileType haskell setlocal expandtab
autocmd FileType python setlocal colorcolumn=80 encoding=latin1 expandtab foldlevel=99 foldmethod=indent
autocmd Filetype python autocmd BufWritePre <buffer> :%s/\s\+$//e
autocmd FileType text setlocal colorcolumn=73 ignorecase noexpandtab textwidth=72 
autocmd FileType c,cpp,cs,java,objc,php setlocal cindent
autocmd FileType javascript setlocal foldlevel=0
autocmd Filetype markdown setlocal spell

let g:neocomplcache_enable_at_startup = 1
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

set statusline=%n\ %f\ %y\ %R\ %m\ %#warningmsg#%{SyntasticStatuslineFlag()}%*\ %{fugitive#statusline()}%=%l/%L,%c

color solarized
