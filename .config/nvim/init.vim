syntax on

call plug#begin('~/.config/nvim/plugged')
Plug 'SirVer/ultisnips'
Plug 'Valloric/YouCompleteMe'
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-bufferline'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/seoul256.vim'
Plug 'justinmk/vim-dirvish'
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-grepper'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
call plug#end()

set background=dark
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
set wildmenu
set wildmode=full

" Cursor keys scroll
nnoremap <Left> zh
nnoremap <Right> zl
nnoremap <Up> gk
nnoremap <Down> gj

" Tagbar
nnoremap <F8> :TagbarToggle<CR>

" FZF to search files and buffers
nnoremap <leader>t :Files<CR>
nnoremap <leader>b :Buffers<CR>

" Use the Platinum Searcher to grep
let g:grepper = {'tools': ['pt']}

" Integreate Fugitive into Lightline
let g:lightline = {
\	'colorscheme': 'seoul256',
\	'active': {
\		'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified', 'fugitive' ] ],
\	},
\	'component': {
\		'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}',
\	},
\	'component_visible_condition': {
\		'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())',
\	},
\}

" Ultisnips YouCompleteMe compatibility
let g:UltiSnipsExpandTrigger = "<c-j>"

colorscheme seoul256
