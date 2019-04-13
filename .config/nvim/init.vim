scriptencoding utf-8

" The plugins I use for language support are:
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
" VimL:
" * ALE (lint using vint)
"
" JSON:
" * ALE (lint using jsonlint, fix using fixjson)
"
" Python:
" * jedi-vim/VimCompletesMe (completion)
" * ALE (lint with pyflakes)
" * semshi (syntax-highlighting)
"
" C/C++:
" * VimCompletesMe/clang_complete: completion 
" * ALE (lint with clang)

packadd minpac
call minpac#init()

call minpac#add('Rip-Rip/clang_complete')
call minpac#add('ajh17/VimCompletesMe')
call minpac#add('dag/vim-fish')
call minpac#add('davidhalter/jedi-vim')
call minpac#add('junegunn/vim-slash')
call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('lifepillar/vim-solarized8')
call minpac#add('luochen1990/rainbow')
call minpac#add('machakann/vim-highlightedyank')
call minpac#add('numirias/semshi')
call minpac#add('ryanoasis/vim-devicons')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-rhubarb')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('w0rp/ale')

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

colorscheme  solarized8

let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1

let g:rainbow_active = 1

let g:clang_library_path = '/usr/lib64/libclang.so'


function!RemoveBackground()
	highlight Normal guibg=NONE
	highlight NonText guibg=NONE
endfunction

augroup cmds
	autocmd!
	autocmd ColorScheme * call RemoveBackground()
augroup end


" TMux compatibility
set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[48;2;%lu;%lu;%lum

