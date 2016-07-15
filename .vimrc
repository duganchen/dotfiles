" ~/.cache/vim needs to be created manually.

set encoding=utf-8

call plug#begin()
Plug 'SirVer/UltiSnips'
Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer'}
Plug 'airblade/vim-gitgutter'
Plug 'dag/vim-fish'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-plug'
Plug 'klen/python-mode', {'branch': 'develop'}
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

" Make sure this directory exists.
set backupdir=~/.cache/vim//
set directory=~/.cache/vim//
set undodir=~/.cache/vim//

set background=dark
if has("osx")
	set clipboard=unnamed
else
	set clipboard+=unnamedplus
endif
set completeopt-=preview
set nohlsearch
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
set wildignore+=.*,*.o,*.pyc,*.swp

" Cursor keys scroll
nnoremap silent <Left> zh
nnoremap silent <Right> zl
nnoremap silent <Down> gj
nnoremap silent <Up> gk

" :Lex(plore) replaces NERDTree
"
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_list_hide = netrw_gitignore#Hide()
function! WDExplorer()
	" http://ivanbrennan.nyc/blog/2014/01/16/rigging-vims-netrw/
	if !exists("g:explorer_nr")
		:Lexplore "" . getcwd()<cr>
		let g:explorer_nr = bufnr("%")
	else
		unlet g:explorer_nr 
		1wincmd w
		bdelete
	endif
endfunction
nnoremap <F2> :call WDExplorer()<cr>
" These seem to produce the same results. Check this.
function! Explorer()
	if !exists("g:explorer_nr")
		:Lexplore<cr>
		let g:explorer_nr = bufnr("%")
	else
		unlet g:explorer_nr 
		1wincmd w
		bdelete
	endif
endfunction
nnoremap <leader>f :call Explorer()<cr>

" FZF
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>t :Files<cr>

let g:fzf_colors =
			\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Tagbar
nnoremap <F8> :TagbarToggle<CR>

" http://vimcasts.org/episodes/bubbling-text/ using unimpaired
if has("osx")
	" Alt+k and Alt+j bubble up on OS X. This works in iterm2.
	nmap ˚ [e 
	nmap ∆ ]e 
	vmap ˚ [egv
	vmap ∆ ]egv
else
	" Escape sequences are the same key sequences on my MacBook Pro keyboard
	nmap <C-Up> [e 
	nmap [A [e
	nmap <C-Down> ]e 
	nmap [B ]e 
	vmap <C-Up> [egv
	vmap [A [egv
	vmap <C-Down> ]egv
	vmap [B ]egv
endif

let g:lightline = {
\	'colorscheme': 'gruvbox',
\	'active': {
\		'left': [[ 'mode', 'paste' ], ['readonly', 'filename', 'modified'], ['fugitive', 'syntastic'], ['gutentags']],
\	},
\	'component_function': {
\		'modified': 'LightlineModified',
\		'fugitive': 'LightlineFugitive',
\		'syntastic': 'LightlineSyntastic',
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

function! LightlineSyntastic()
	let l:status = SyntasticStatuslineFlag()
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

let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsEditSplit = "vertical"

" https://github.com/SirVer/ultisnips/issues/711#issuecomment-227159748
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']

let g:gutentags_cache_dir = $HOME . "/.cache/vim"

let g:pymode_lint = 0
let g:pymode_options_max_line_length = 138
let g:pymode_options_colorcolumn = 0
let g:pymode_breakpoint = 0


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
