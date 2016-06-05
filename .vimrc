syntax on 

set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'SirVer/UltiSnips'
Plugin 'Valloric/YouCompleteMe'
Plugin 'VundleVim/Vundle.vim'
Plugin 'Yggdroot/indentLine'
Plugin 'airblade/vim-gitgutter'
Plugin 'airblade/vim-rooter'
Plugin 'bling/vim-bufferline'
Plugin 'dag/vim-fish'
Plugin 'itchyny/lightline.vim'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/seoul256.vim'
Plugin 'klen/python-mode'
Plugin 'kshenoy/vim-signature'
Plugin 'majutsushi/tagbar'
Plugin 'mhinz/vim-grepper'
Plugin 'scrooloose/syntastic'
Plugin 'shime/vim-livedown'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'vimwiki/vimwiki'
call vundle#end()

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
set shell=bash
set shiftwidth=4
set smartcase
set smarttab
set t_Co=256
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
\	'colorscheme': 'seoul256',
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

colorscheme seoul256

highlight normal ctermbg=None
