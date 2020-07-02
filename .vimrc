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

if filereadable(expand('$VIMRUNTIME/defaults.vim'))
    unlet! g:skip_defaults_vim
    source $VIMRUNTIME/defaults.vim
endif
packadd minpac
call minpac#init()

call minpac#add('ajh17/VimCompletesMe')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('arcticicestudio/nord-vim')
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
call minpac#add('mike-hearn/base16-vim-lightline')
call minpac#add('romainl/vim-qf')
call minpac#add('ryanoasis/vim-devicons')
call minpac#add('thirtythreeforty/lessspace.vim')
call minpac#add('vim-airline/vim-airline')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-dispatch')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-rhubarb')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-sleuth')

if !isdirectory(expand('~/.cache/vim'))
    call mkdir(expand('~/.cache/vim'))
endif

set autoread
set backupdir=~/.cache/vim//
set directory=~/.cache/vim//
set grepprg=rg\ --vimgrep
set hidden

set linebreak
set noshowmode
set number
set relativenumber
set shell=bash

set termguicolors

set undodir=~/.cache/vim//
set undofile
set updatetime=100

set background=dark

let g:rainbow_active = 1

let g:airline_powerline_fonts = 1

let g:nord_bold = 1
let g:nord_italic = 1
let g:nord_underline = 1
let g:nord_italic_comments = 1
colorscheme nord

if !has('gui_running') && !has('mac')
	" For background redraw issues.
	" https://superuser.com/a/588243
	" set t_ut=

	" Transparent background.
	" highlight Normal guibg=NONE

	if !empty($TMUX)
		set t_8f=[38;2;%lu;%lu;%lum
		set t_8b=[48;2;%lu;%lu;%lum
	endif

	" https://github.com/ryanoasis/vim-devicons/issues/266#issuecomment-599166010
	if $TERM == 'xterm-kitty'
	    set t_RV=
	endif
end

augroup autocmds
	autocmd!
	autocmd BufEnter,BufNew * silent! Glcd
	autocmd BufEnter,BufNew configure.ac setlocal filetype=m4
	autocmd BufEnter,BufNew *.qrc setlocal filetype=xml
augroup END


" :Files is FZF
nnoremap \t :Files<cr>

" You know, I've never found anything actually better than this.
nnoremap \b :ls<cr>:b<space>

