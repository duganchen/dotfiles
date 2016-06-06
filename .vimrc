call plug#begin()
Plug 'SirVer/UltiSnips'
Plug 'Valloric/YouCompleteMe'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'bling/vim-bufferline'
Plug 'dag/vim-fish'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-plug'
Plug 'klen/python-mode'
Plug 'kshenoy/vim-signature'
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-grepper'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/syntastic'
Plug 'shime/vim-livedown'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vimwiki/vimwiki'
call plug#end()

syntax on 
filetype plugin indent on

set background=dark

set clipboard+=unnamedplus
set completeopt-=preview
set nohlsearch
set nobackup
set hidden
set incsearch
set nocompatible

" Lightline provides this
set noshowmode

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
set visualbell
set wildmenu
set wildmode=full

" Cursor keys scroll
nnoremap <Left> zh
nnoremap <Right> zl
nnoremap <Up> gk
nnoremap <Down> gj

let g:netrw_banner = 0
let g:netrw_liststyle = 3

" Tagbar
nnoremap <F8> :TagbarToggle<CR>

" FZF to search files and buffers
nnoremap <leader>t :Files<CR>
nnoremap <leader>b :Buffers<CR>

" Use the Platinum Searcher to grep
let g:grepper = {'tools': ['pt']}

" Integrate Fugitive into Lightline
let g:lightline = {
\	'colorscheme': 'gruvbox',
\	'active': {
\		'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified', 'fugitive' ] ],
\	},
\	'component': {
\		'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}',
\		'readonly': '%{&readonly?"":""}',
\	},
\	'component_visible_condition': {
\		'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())',
\	},
\	'separator': {
\		'left': '',
\		'right': '',
\	},
\	'subseparator': {
\		'left': '',
\		'right': '',
\	}
\}

" Let python-mode handle Python
let g:syntastic_mode_map = {
\	"mode": "active",
\	"passive_filetypes": ["python"],
\}
let g:ycm_filetype_blacklist = {
\	'python' : 1,
\}

let g:livedown_browser="/usr/lib64/chromium/chromium"
let g:livedown_autorun=1
let g:livedown_open=1

let g:UltiSnipsExpandTrigger="<c-j>"
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
augroup END

let g:gruvbox_italic=1
colorscheme gruvbox
