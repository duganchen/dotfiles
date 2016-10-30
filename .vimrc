unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'dag/vim-fish'
Plug 'drgarcia1986/python-compilers.vim'
Plug 'junegunn/vim-plug'
Plug 'ludovicchabant/vim-gutentags'
Plug 'morhetz/gruvbox'
Plug 'pangloss/vim-javascript'
Plug 'thirtythreeforty/lessspace.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
call plug#end()

set clipboard^=unnamedplus,unnamed

" Correct on Linux. Correct on OS X, AFAIK
set ttymouse=xterm2

" Make sure this directory exists.
set backupdir=~/.cache/vim//
set directory=~/.cache/vim//
set undodir=~/.cache/vim//

let g:gutentags_cache_dir = $HOME . "/.cache/vim"

" GitHub's desktop-browser web interface can display 137 characters per line without a horizontal scrollbar.
set colorcolumn=138
set textwidth=137

set cscopetag

set number
set relativenumber

set completeopt-=preview
set omnifunc=syntaxcomplete#Complete

set fillchars=vert:\│

set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

set shell=bash

set shiftwidth=4
set tabstop=4

set ttyfast

set path=.,**

" http://vimcasts.org/episodes/bubbling-text/ using unimpaired
if has("osx")
	" Alt+k and Alt+j bubble up on OS X. This works in iterm2.
	nmap ˚ [e 
	nmap ∆ ]e 
	vmap ˚ [egv
	vmap ∆ ]egv
else
	" Escape sequences are the same key sequences on my MacBook Pro keyboard
	nmap [A [e
	nmap [B ]e 
	vmap [A [egv
	vmap [B ]egv
	nmap <C-Up> [e 
	nmap <C-Down> ]e 
	vmap <C-Up> [egv
	vmap <C-Down> ]egv
endif

set background=dark
if !has('gui')
	set t_8f=[38;2;%lu;%lu;%lum
	set t_8b=[48;2;%lu;%lu;%lum
endif
function ColorSchemeChange()
	if !has('gui')
		highlight Normal ctermbg=NONE guibg=NONE
		highlight NonText ctermbg=NONE guibg=NONE

		" termguicolors needs to be set after the colorscheme, it seems
		set termguicolors
	endif
endfunction

function FileTypePython()
	compiler flake8
endfunction

augroup autocmds
	autocmd!
	autocmd ColorScheme * call ColorSchemeChange()
	autocmd FileType vifm set filetype=vim
	autocmd FileType python call FileTypePython()
augroup END

let g:gruvbox_italic=1
colorscheme gruvbox
