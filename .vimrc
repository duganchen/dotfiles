scriptencoding utf-8

" Needs a NERD font.
"
" Apart from the NERD font, I'm going for vim purity. My language support
" is:
"
" * makeprg
" * formatprg
" * omnicomplete (with plugin-provided omnifuncs)
" * ctags (with Universal Ctags)
" * cscope (with GNU Global)

" Currently using Solarized with Powerline and Linux, and Gruvbox on OS X.

if filereadable(expand('$VIMRUNTIME/defaults.vim'))
    unlet! g:skip_defaults_vim
    source $VIMRUNTIME/defaults.vim
endif
packadd minpac
call minpac#init()

call minpac#add('ajh17/VimCompletesMe')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('dag/vim-fish')
call minpac#add('davidhalter/jedi-vim')
call minpac#add('junegunn/fzf')
call minpac#add('junegunn/fzf.vim')
call minpac#add('junegunn/vim-slash')
call minpac#add('justinmk/vim-dirvish')
call minpac#add('justmao945/vim-clang')
call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('luochen1990/rainbow')
call minpac#add('machakann/vim-highlightedyank')
call minpac#add('romainl/vim-qf')
call minpac#add('sonph/onehalf', {'rtp': 'vim'})
call minpac#add('srcery-colors/srcery-vim')
call minpac#add('thirtythreeforty/lessspace.vim')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-dispatch')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-rhubarb')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('vim-airline/vim-airline')

if !isdirectory(expand('~/.cache/vim'))
    call mkdir(expand('~/.cache/vim'))
endif

set backupdir=~/.cache/vim//
set directory=~/.cache/vim//
set grepprg=rg\ --vimgrep
set hidden
set linebreak
set number
set relativenumber
set shell=bash


" TMux compatibility
set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[48;2;%lu;%lu;%lum


set termguicolors

set undodir=~/.cache/vim//
set undofile
set updatetime=100

set background=dark

colorscheme srcery

" For background redraw issues.
" https://superuser.com/a/588243
set t_ut=

" Uncomment for a transparent background.
" highlight Normal guibg=NONE

let g:airline_powerline_fonts = 1

let g:rainbow_active = 1

augroup autocmds
	autocmd!
	autocmd BufEnter,BufNew * silent! Glcd
augroup END


" :Files is FZF
nnoremap \t :Files<cr>

" You know, I've never found anything actually better than this.
nnoremap \b :ls<cr>:b<space>

