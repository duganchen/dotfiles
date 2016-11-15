if !has('nvim')
	unlet! skip_defaults_vim
	source $VIMRUNTIME/defaults.vim
endif

packadd vim-devicons

set autoindent
set autoread

if !has('mac')
	set clipboard^=unnamedplus,unnamed
endif

set infercase

" Correct on Linux. Correct on OS X, AFAIK
if !has('nvim')
	set ttymouse=xterm2
endif

" Make sure this directory exists.
set backupdir=~/.cache/vim//
set directory=~/.cache/vim//
set undodir=~/.cache/vim//

let g:gutentags_cache_dir = $HOME . "/.cache/vim"

" GitHub's desktop-browser web interface can display 137 characters per line without a horizontal scrollbar.
set colorcolumn=138
set textwidth=137

set complete-=i

set cscopetag

set display=lastline

set formatoptions+=j

set hidden

set laststatus=2

set number
set relativenumber

set sessionoptions-=options

set completeopt-=preview
set omnifunc=syntaxcomplete#Complete

set fillchars=vert:\│

set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

set shell=bash

set shiftwidth=4
set smartcase
set smarttab
set softtabstop=4
set tabstop=4

set ttyfast

set viminfo^=!

set path=.,**

set visualbell

set nowrap

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

" https://www.reddit.com/r/vim/comments/45qe2g/unite_vs_ctrlp_in_2016/d00u7y4/
" https://robots.thoughtbot.com/faster-grepping-in-vim
let g:ctrlp_user_command = {
	\'types': {
		\1: ['.git', 'cd %s && git ls-files --others --cached --exclude-standard'],
	\},
	\'fallback': 'ag %s -l --nocolor -g ""'
	\}
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_user_command = {}
let g:ctrlp_working_path_mode = 0
let g:ctrlp_regexp = 1

let g:lightline = {
	\'component': {
		\'filename': '%n:%t',
	\},
	\'component_function': {
		\'filetype': 'MyFiletype',
		\'fileformat': 'MyFileformat',
	\}
\}

function! MyFiletype()
	return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
	return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! ColorSchemeChange()
	if has('nvim')
		highlight! Normal guibg=NONE
		highlight! NonText guibg=NONE
	endif
endfunction

augroup autocmds
	autocmd!
	autocmd FileType vifm set filetype=vim
	autocmd ColorScheme * call ColorSchemeChange()
augroup END


if !has('gui') && has('termguicolors')
	" ^[ is a single character: Ctrl+V,<ESC>
	" This is for tmux.

	if !has('nvim')
		let &t_8f = "[38;2;%lu;%lu;%lum"
		let &t_8b = "[48;2;%lu;%lu;%lum"
	endif

	set termguicolors

	if !has('mac') && !has('nvim')
		" Seems to be needed in transparent Termite.
		set t_ut=
	endif
endif

if !has('gui')
	set background=dark
endif

" koehler is good with transparent terminals; evening is better opaque.
if has('mac') || has('nvim')
	colorscheme koehler
else
	colorscheme evening
endif
