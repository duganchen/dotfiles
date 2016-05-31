syntax on

call plug#begin('~/.config/nvim/plugged')
Plug 'SirVer/ultisnips'
Plug 'Valloric/YouCompleteMe'
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-bufferline'
Plug 'dag/vim-fish'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'klen/python-mode'
Plug 'kshenoy/vim-signature'
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-grepper'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/syntastic'
Plug 'shime/vim-livedown'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
call plug#end()

set background=dark
set completeopt-=preview
set nohlsearch
set nobackup
set hidden
set incsearch

" Lightline provides this
set noshowmode

set number
set relativenumber
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

" Ultisnips YouCompleteMe compatibility
let g:UltiSnipsExpandTrigger = "<c-j>"

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

" They don't seem to work on 14.1. Sigh.
let g:gruvbox_italic=0

colorscheme gruvbox
