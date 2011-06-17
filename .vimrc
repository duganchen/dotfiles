filetype plugin indent on
syntax enable

set shiftwidth=4 tabstop=4 softtabstop=4 showcmd hlsearch incsearch smartcase autoindent ruler showmode visualbell ruler nobackup textwidth=0 wrap noignorecase smarttab spelllang=en_ca number omnifunc=syntaxcomplete#Complete showmatch title noerrorbells noswapfile t_Co=256 mouse=a nocompatible wildmenu ttyfast encoding=utf-8

autocmd FileType python setlocal expandtab list colorcolumn=80 encoding=latin1
autocmd FileType text setlocal spell ignorecase noexpandtab textwidth=72 colorcolumn=73

" http://www.vim.org/scripts/script.php?script_id=1143
color inkpot

" Switch to xoria256 when mc 4.8 comes out.
"
" Download from:
" http://www.vim.org/scripts/script.php?script_id=2140
"
" Matching mc theme:
" http://www.midnight-commander.org/browser/misc/skins/xoria256.ini
" color xoria256
