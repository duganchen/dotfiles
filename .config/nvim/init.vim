let g:glsl_file_extensions = '*.glsl,*.frag,*.vert,*.slf,*.slv,*.vsh,*.fsh'

call plug#begin('~/.config/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/syntastic'
Plug 'dag/vim-fish'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'hynek/vim-python-pep8-indent'
Plug 'jmcantrell/vim-virtualenv'
Plug 'airblade/vim-gitgutter'
Plug 'luochen1990/rainbow'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'beyondmarc/glsl.vim'
call plug#end()

" Don't show the YouCompleteMe preview window.
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_enable_signs = 1

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

syntax enable

set background=dark
set wildmenu
set wildignore=*.pyc,*.swp,*.o

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

let g:gruvbox_italic=1
colorscheme gruvbox

let g:lightline = { 'colorscheme': 'gruvbox', }

augroup initialization
	autocmd!
	" http://vim.wikia.com/wiki/Remove_unwanted_spaces
	" autocmd BufWritePre * :%s/\s\+$//e
	"
	autocmd FileType python setlocal expandtab foldmethod=indent nowrap
	autocmd FileType text setlocal colorcolumn=73 ignorecase noexpandtab textwidth=72
	autocmd FileType c,cpp,cs,java,javascript,objc,php setlocal cindent tabstop=4 shiftwidth=4 foldmethod=syntax nowrap
	autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
	autocmd BufNewFile,BufRead *.SlackBuild setlocal filetype=sh

	" When do you ever get .ac files other than configure.ac?
	autocmd BufNewFile,BufRead *.ac setlocal filetype=m4
augroup END

" Syntastic handles bdelete.
nnoremap <silent> <C-d> :lclose<CR>:bdelete<CR>
cabbrev <silent> bd <C-r>=(getcmdtype()==#':' && getcmdpos()==1 ? 'lclose\|bdelete' : 'bd')<CR>

" FZF

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nnoremap <leader>t :Files<CR>
nnoremap <leader>b :Buffers<CR>

" Transparent neovim
highlight Normal guibg=None
highlight NonText guibg=None

let g:ycm_confirm_extra_conf = 0
