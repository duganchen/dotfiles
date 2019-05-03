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

" Currently using Solarized with Powerline and Linux, and base16 on OS X. My
" base16 setup is:
" * https://browntreelabs.com/base-16-shell-and-why-its-so-awsome/
" * https://github.com/jatap/tmux-base16-statusline

if filereadable(expand('$VIMRUNTIME/defaults.vim'))
    unlet! g:skip_defaults_vim
    source $VIMRUNTIME/defaults.vim
endif
packadd minpac
call minpac#init()

call minpac#add('ajh17/VimCompletesMe')
call minpac#add('chriskempson/base16-vim')
call minpac#add('dag/vim-fish')
call minpac#add('davidhalter/jedi-vim')
call minpac#add('junegunn/vim-slash')
call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('lifepillar/vim-solarized8')
call minpac#add('luochen1990/rainbow')
call minpac#add('machakann/vim-highlightedyank')
call minpac#add('romainl/vim-qf')
call minpac#add('ryanoasis/vim-devicons')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-dispatch')
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
set grepprg=rg\ --vimgrep
set hidden
set number
set relativenumber
set shell=bash
set termguicolors
set undodir=~/.cache/vim//
set undofile
set updatetime=100

set background=dark

if has('mac')
	colorscheme base16-default-dark
	let g:airline_theme='base16_default'
	highlight Normal guibg=NONE
else
	colorscheme solarized8
	let g:airline_theme='solarized'
end

let g:airline_powerline_fonts = 1

let g:rainbow_active = 1

function CheckSlackBuildInfo()
	if filereadable(expand('%:p:r'). '.SlackBuild')
		setlocal filetype=sh
	endif
endfunction

augroup autocmds
	autocmd!
	autocmd BufEnter,BufNew *.info call CheckSlackBuildInfo()
augroup END

" TMux compatibility
set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[48;2;%lu;%lu;%lum

