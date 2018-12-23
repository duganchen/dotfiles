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

packadd minpac
call minpac#init()

" Note: ALE seems to have issues with neovim > 0.3.1
" https://github.com/w0rp/ale/issues/2160
call minpac#add('w0rp/ale')

" Been having installation issues with this. Not sure if it's because it's
" sensitive to ordering, or if it's because I'm quitting vim too early.
call minpac#add('autozimu/LanguageClient-neovim', {'branch': 'next', 'do': {->system('bash install.sh')}})

call minpac#add('Shougo/deoplete.nvim')

call minpac#add('Shougo/neco-vim')

call minpac#add('airblade/vim-gitgutter')
call minpac#add('chriskempson/base16-vim')

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
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')

if !isdirectory(expand('~/.cache/vim'))
    call mkdir(expand('~/.cache/vim'))
endif
set backupdir=~/.cache/vim//
set directory=~/.cache/vim//
set undodir=~/.cache/vim//
set undofile

" For vim-gitgutter. Recommended by its README.
set updatetime=100

let g:airline_powerline_fonts = 1
let g:ale_sign_column_always = 1
let g:deoplete#enable_at_startup = 1
let g:rainbow_active = 1

let g:ale_linters_explicit = 1
let g:LanguageClient_serverCommands = {
    \'python': ['pyls'],
    \'c': ['clangd'],
    \'cpp': ['clangd'],}

set termguicolors
colorscheme base16-bright
augroup cmds
autocmd!
autocmd ColorScheme base16-bright highlight Normal guibg=None
augroup END
