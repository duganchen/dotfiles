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

let g:netrw_altv=1
let g:netrw_browse_split=4
let g:netrw_banner=0
let g:netrw_keepdir=0
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_winsize=25

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

function! StatusReadOnly()
	return &ft !~? 'help' && &readonly ? ' ' : ''
endfunction

function! StatusModified()
	return &ft =~ 'help' ? '' : &modified ? '+ ' : &modifiable ? '' : '- '
endfunction

function! StatusFugitive()
	let l:status = fugitive#statusline()
	if strlen(l:status)
		" TODO: Get rid of the Git()
		" http://stackoverflow.com/a/3135448
		return l:status[1: -2] . " "
	endif
	return ""
endfunction

function! StatusFileFormat()
	return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! StatusFileType()
	return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

set statusline=
			\%n
			\\ %{StatusReadOnly()}
			\%{StatusModified()}
			\%{StatusFugitive()}
			\%.60F
			\%=
  			\%{StatusFileFormat()}
 			\%{StatusFileType()}
			\\ %p%%
			\\ %l:%v

function FileTypePython()
	compiler flake8
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
	autocmd FileType python call FileTypePython()
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
