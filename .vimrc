unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'dag/vim-fish'
Plug 'drgarcia1986/python-compilers.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-plug'
Plug 'ludovicchabant/vim-gutentags'
Plug 'morhetz/gruvbox'
Plug 'pangloss/vim-javascript'
Plug 'ryanoasis/vim-devicons'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'thirtythreeforty/lessspace.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
call plug#end()

if has("osx")
	set clipboard=unnamed
else
	set clipboard+=unnamedplus
endif

" Correct on OS X, AFAIK
set ttymouse=xterm2

" Make sure this directory exists.
set backupdir=~/.cache/vim//
set directory=~/.cache/vim//
set undodir=~/.cache/vim//

let g:gutentags_cache_dir = $HOME . "/.cache/vim"

" GitHub's desktop-browser web interface can display 137 characters per line without a horizontal scrollbar.
set colorcolumn=138
set cscopetag
set textwidth=137

set number
set relativenumber

set completeopt-=preview
set omnifunc=syntaxcomplete#Complete

set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

set shell=bash

set shiftwidth=4
set tabstop=4

" FZF
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>t :Files<cr>
let g:fzf_colors = {
\	'fg':      ['fg', 'Normal'],
\	'bg':      ['bg', 'Normal'],
\	'hl':      ['fg', 'Comment'],
\	'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\	'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
\	'hl+':     ['fg', 'Statement'],
\	'info':    ['fg', 'PreProc'],
\	'prompt':  ['fg', 'Conditional'],
\	'pointer': ['fg', 'Exception'],
\	'marker':  ['fg', 'Keyword'],
\	'spinner': ['fg', 'Label'],
\	'header':  ['fg', 'Comment']
\}

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

let g:lightline = {
\	'colorscheme': 'gruvbox',
\	'active': {
\		'left': [[ 'mode', 'paste' ], ['readonly', 'filename', 'modified'], ['fugitive', 'gutentags']],
\	},
\	'component_function': {
\		'modified': 'LightlineModified',
\		'fugitive': 'LightlineFugitive',
\		'gutentags': 'LightlineGutenTags',
\		'readonly': 'LightLineReadonly',
\		'fileformat': 'LightlineFileFormat',
\		'filetype': 'LightlineFileType'
\	},
\	'separator': {
\		'left': '',
\		'right': '',
\	},
\	'subseparator': {
\		'left': '',
\		'right': '',
\	},
\}

function! LightlineModified()
	return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
	return &ft !~? 'help' && &readonly ? '' : ''
endfunction

function! LightlineFugitive()
	let l:status = fugitive#statusline()
	if strlen(l:status)
		return l:status[1: -2]
	endif
	return ""
endfunction

function! LightlineGutenTags()
	return gutentags#statusline()
endfunction

function! LightlineFileType()
	return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! LightlineFileFormat()
	return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

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
