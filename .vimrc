unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

set autoindent
set autoread

if !has('mac')
	set clipboard^=unnamedplus,unnamed
endif

set infercase

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

nnoremap <leader>b :ls<CR>:b<space>

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
			\%F
			\%=
			\%{StatusFileFormat()}
			\%{StatusFileType()}
			\\ %p%%
			\\ %l:%v

function FileTypePython()
	compiler flake8
endfunction

augroup autocmds
	autocmd!
	autocmd FileType vifm set filetype=vim
	autocmd FileType python call FileTypePython()
augroup END

set background=dark

if !has('gui')
	" ^[ is a single character: Ctrl+V,<ESC>
	let &t_8f = "[38;2;%lu;%lu;%lum"
	let &t_8b = "[48;2;%lu;%lu;%lum"

	set termguicolors

	if !has('mac')
		" My transparent terminals seem to need this
		" https://sunaku.github.io/vim-256color-bce.html
		set t_ut=
	endif
endif

if !has('mac')
	" I'll have to get this working later.
	let g:gruvbox_italic=1
endif

colorscheme gruvbox
