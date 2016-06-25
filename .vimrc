" For now I'll be using:
"
" grepper: vimgrep
" fuzzyfinder: :e **/partial<TAB>
" buffer manager: :ls :b as my 
" file browser: lex

set encoding=utf-8

call plug#begin()
Plug 'SirVer/UltiSnips'
Plug 'Valloric/YouCompleteMe'
Plug 'airblade/vim-gitgutter'
Plug 'dag/vim-fish'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/vim-plug'
Plug 'klen/python-mode'
Plug 'kshenoy/vim-signature'
Plug 'majutsushi/tagbar'
Plug 'morhetz/gruvbox'
Plug 'ludovicchabant/vim-gutentags'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/syntastic'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
call plug#end()

syntax on
filetype plugin indent on

" GitHub's desktop-browser web interface can display 137 characters per line without a horizontal scrollbar.
set colorcolumn=138
set textwidth=137

set background=dark
set clipboard+=unnamedplus
set completeopt-=preview
set nohlsearch
set nobackup
set hidden
set incsearch
set mouse=a
set nocompatible

" Lightline provides this
set noshowmode

set nowrap
set number
set relativenumber

" https://www.reddit.com/r/vim/comments/4hoa6e/what_do_you_use_for_your_listchars/d2re0mg
set showbreak=↪
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨

set shell=bash
set shiftwidth=4
set smartcase
set smarttab
set tabstop=4
set ttymouse=xterm2
set visualbell
set wildmenu
set wildmode=full
set wildignore+=*.o,*.swp,*.pyc

" Cursor keys scroll
nnoremap <Left> zh
nnoremap <Right> zl
nnoremap <Down> gj
nnoremap <Up> gk

" :Lex(plore) replaces NerdTree
let g:netrw_banner = 0
let g:netrw_liststyle = 3

" http://of-vim-and-vigor.blogspot.ca/p/vim-vigor-comic.html
" This is my buffer manager.
nnoremap <leader>b :ls<CR>:b<space>

" And this is my fuzzyfinder.
nnoremap <leader>t :e **/

" Tagbar
nnoremap <F8> :TagbarToggle<CR>

" http://vimcasts.org/episodes/bubbling-text/ using unimpaired
" Escape sequences are the same key sequences on my MacBook Pro keyboard
nmap <C-Up> [e 
nmap [A [e
nmap <C-Down> ]e 
nmap [B ]e 
vmap <C-Up> [egv
vmap [A [egv
vmap <C-Down> ]egv
vmap [B ]egv

let g:lightline = {
\	'colorscheme': 'gruvbox',
\	'active': {
\		'left': [[ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified'], ['fugitive', 'gutentags']],
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
	return exists('*fugitive#head') ? fugitive#head() : ''
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

" Let python-mode handle Python
let g:syntastic_mode_map = {
\	"mode": "active",
\	"passive_filetypes": ["python"],
\}
let g:ycm_filetype_blacklist = {
\	'python' : 1,
\}

let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsEditSplit = "vertical"

" https://github.com/SirVer/ultisnips/issues/711#issuecomment-227159748
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']

let g:gutentags_cache_dir = $HOME . "/.vim/tags"

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

augroup autocmds
	autocmd!
	autocmd ColorScheme * call ColorSchemeChange()

	" for a current C project
	autocmd FileType c call FileTypeC()
	autocmd FileType cpp call FileTypeC()
	autocmd BufWritePre *.cpp,*.c,*.h call PreWriteC()
augroup END

let g:gruvbox_italic=1
colorscheme gruvbox

" Some stuff for a current project. Might not keep forever.

function FileTypeC()
	set expandtab
endfunction()

function PreWriteC()
	:%s/\s\+$//e
endfunction
