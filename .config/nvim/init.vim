scriptencoding utf-8

" The plugins I use for language support are:
"
" VimL:
" * ALE (lint using vint)
" * deoplete/neco (autocompletion)
"
" BASH:
" * ALE (lint using shellcheck)
"
" FISH:
" * ALE
"   * lint using fish
"   * fix using fish_indent
" * vim-fish (colors/indent)
"
" Python:
" * semshi (syntax-highlighting)
" * deoplete/LanguageClient-neovim (pyls integration)
"
" C/C++:
" * Chromatica (syntax-highlighting)
" * deoplete/LanguageClient_neovim (clangd integration)

packadd minpac
call minpac#init()

call minpac#add('w0rp/ale')

" Been having installation issues with this. Not sure if it's because it's
" sensitive to ordering, or if it's because I'm quitting vim too early.
call minpac#add('autozimu/LanguageClient-neovim', {'branch': 'next', 'do': {->system('bash install.sh')}})

call minpac#add('Shougo/deoplete.nvim')

call minpac#add('Shougo/neco-vim')

call minpac#add('airblade/vim-gitgutter')
call minpac#add('arakashic/chromatica.nvim')
call minpac#add('chriskempson/base16-vim')
call minpac#add('ctrlpvim/ctrlp.vim')
call minpac#add('dag/vim-fish')
call minpac#add('junegunn/gv.vim')
call minpac#add('junegunn/vim-slash')
call minpac#add('luochen1990/rainbow')
call minpac#add('machakann/vim-highlightedyank')
call minpac#add('numirias/semshi')
call minpac#add('ryanoasis/vim-devicons')
call minpac#add('thirtythreeforty/lessspace.vim')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-rhubarb')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-vinegar')
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('Yggdroot/LeaderF', {'do': {->system('bash install.sh')}})

if !isdirectory(expand('~/.cache/vim'))
    call mkdir(expand('~/.cache/vim'))
endif
set backupdir=~/.cache/vim//
set directory=~/.cache/vim//
set undodir=~/.cache/vim//
set undofile
set grepprg=rg\ --vimgrep
set shell=bash
set number
set relativenumber

" For vim-gitgutter. Recommended by its README.
set updatetime=100

let g:airline_powerline_fonts = 1
let g:ale_sign_column_always = 1
let g:deoplete#enable_at_startup = 1
let g:rainbow_active = 1

" Fd syntax from here:
" https://www.reddit.com/r/vim/comments/83h31q/speed_up_ctrlp_with_fd/
let g:ctrlp_user_command = {
	\ 'types': {
		\ 1: ['.git', 'cd %s && git ls-files'],
	\ },
	\ 'fallback': 'fd --type f -c never "" %s'
\ }
nnoremap <leader>b :CtrlPBuffer<cr>

let g:ale_linters_explicit = 1
let g:LanguageClient_serverCommands = {
    \'python': ['pyls'],
    \'c': ['clangd'],
    \'cpp': ['clangd'],}

if filereadable('/usr/local/opt/llvm/lib/libclang.dylib')
	let g:chromatica#libclang_path='/usr/local/opt/llvm/lib/libclang.dylib'
elseif filereadable('/usr/lib64/libclang.so')
	let g:chromatica#libclang_path='/usr/lib64/libclang.so'
endif
let g:chromatica#enable_at_startup=1

set termguicolors
colorscheme base16-bright
augroup cmds
autocmd!
autocmd BufEnter,BufNew * silent! Glcd
autocmd ColorScheme base16-bright highlight Normal guibg=None
augroup END
