if !has('nvim')
	unlet! skip_defaults_vim
	source $VIMRUNTIME/defaults.vim
endif

call plug#begin()
Plug 'Rip-Rip/clang_complete'
Plug 'ajh17/VimCompletesMe'
Plug 'airblade/vim-gitgutter'
Plug 'davidhalter/jedi-vim'
Plug 'gcmt/taboo.vim'
Plug 'itchyny/lightline.vim'
Plug 'jeetsukumaran/vim-filebeagle'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/vim-slash'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'python-rope/ropevim'
Plug 'sheerun/vim-polyglot'
Plug 'shirataki/lightline-onedark'
Plug 'tmhedberg/SimpylFold'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'ryanoasis/vim-devicons'
call plug#end()

" I also tend to use the Flake8 compiler plugin from here:
" https://github.com/drgarcia1986/python-compilers.vim

" Settings:
" CompilerSet makeprg=flake8\ %
" CompilerSet errorformat=%E%f:%l:\ could\ not\ compile,
"                         \%-Z%p^,
"                         \%A%f:%l:%c:\ %t%n\ %m,
"                         \%A%f:%l:\ %t%n\ %m,
"                         \%-G%.%#

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

set wildignore+=*.pyc,*.o

set nowrap

set fillchars=vert:\│

nmap <F8> :TagbarToggle<CR>

" https://www.reddit.com/r/vim/comments/2zc8sy/poors_man_vimrooter_git_only_using_fugitive/

function! OnBufEnter()
	if exists('b:last_cwd')
		execute 'lcd' b:last_cwd
	else
		silent! Glcd
	endif
endfunction

function! OnBufLeave()
	let b:last_cwd = getcwd()
endfunction

" Ideas from here:
" https://www.reddit.com/r/vim/comments/4hoa6e/what_do_you_use_for_your_listchars/
let &showbreak = '↪  '
set listchars=tab:\│\ ,extends:›,precedes:‹,nbsp:␣,trail:·,eol:↲

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

set noshowmode
let g:lightline = {
	\'component': {
		\'lineinfo': ' %3l:%-2v',
	\},
	\'component_function': {
		\'filename': 'MyFilename',
		\'filetype': 'MyFiletype',
		\'fileformat': 'MyFileformat',
		\'readonly': 'LightlineReadonly',
		\'fugitive': 'LightlineFugitive',
	\},
	\'active': {
		\'left': [  [ 'mode', 'paste' ], [ 'readonly', 'fugitive', 'filename', 'modified' ] ],
	\},
\}

function! MyFiletype()
	return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
	return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! LightlineReadonly()
	if &filetype == "help"
		return ""
	elseif &readonly
		return ''
	else
		return ""
	endif
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
	autocmd BufEnter * call OnBufEnter()
	autocmd BufLeave * call OnBufLeave()
	autocmd VimResized * wincmd =
augroup END

function! LightlineFugitive()
	if exists('*fugitive#head')
		let branch = fugitive#head()
		return branch !=# '' ? ' '.branch : ''
	endif
	return ''
endfunction

if !has('gui') && has('termguicolors')
	if !has('nvim')
		" ^[ is a single character: Ctrl+V,<ESC>
		" This is for tmux.
		let &t_8f = "[38;2;%lu;%lu;%lum"
		let &t_8b = "[48;2;%lu;%lu;%lum"
	endif

	set termguicolors

	" if !has('mac') && !has('nvim')
	" 	" Seems to be needed in transparent Termite.
	" 	set t_ut=
	" endif
endif

function! MyFilename()
	return bufnr('%') . ':' . fnamemodify(expand('%:p'), ':~:.')
endfunction

set background=dark

if has('nvim') || has('mac')
	colorscheme koehler
else
	let g:lightline.colorscheme = 'onedark'
	let g:onedark_terminal_italics = 1
	colorscheme onedark
endif
