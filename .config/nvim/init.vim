call plug#begin('~/.local/share/nvim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'justinmk/vim-dirvish'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'machakann/vim-highlightedyank'
Plug 'junegunn/vim-slash'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'bluz71/vim-moonfly-colors'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

" Don't mind if I steal a couple of lines from here:
" https://www.reddit.com/r/neovim/comments/3oeko4/post_your_fzfvim_configurations/cvworyj
nnoremap <silent> <leader>t :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>

lua require "treesitter"
lua require "lsp"

" For nvim-completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set completeopt=menuone,noinsert,noselect
set shortmess+=c

" For nvim-diagnostics
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_virtual_text_prefix = ' '

" Treesitter
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" From here 
" https://www.reddit.com/r/neovim/comments/gu08zv/nvimlsp_statusline/fsgcam4
function! StatuslineLsp() abort
	return luaeval("require('lsp-status').status()")
endfunction

augroup lsp
	" The formatting capabilities of the Typescript server are better off
	" not being used.
	" https://github.com/theia-ide/typescript-language-server/issues/10
	"
	" Leaving this out while I figure out why it's not working
	" autocmd BufWritePre *.cpp,*.vim,*.py,*.lua lua vim.lsp.buf.formatting_sync(nil, 1000)
augroup END

set termguicolors
colorscheme moonfly
highlight Normal guibg=NONE

" For lightline
set noshowmode

let g:lightline = {
	\'colorscheme': 'moonfly',
	\'active': {
	\'left': [
	\	['mode', 'paste'],
	\	[ 'readonly', 'filename', 'modified'],
	\	['fugitive', 'lsp']]
	\},
	\ 'component': {
	\ 	'lineinfo': ' %3l:%-2c',
	\ },
	\ 'component_function': {
	\	'readonly': 'LightlineReadonly',
	\	'fugitive': 'LightlineFugitive',
	\	'filetype': 'MyFiletype',
	\	'fileformat': 'MyFileformat',
	\	'lsp': 'StatuslineLsp'
	\},
	\	'separator': { 'left': '', 'right': '' },
	\	'subseparator': { 'left': '', 'right': '' }
	\}


function! MyFiletype()
	return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
	return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! LightlineReadonly()
	return &readonly ? '' : ''
endfunction

function! LightlineFugitive()
	if exists('*FugitiveHead')
		let branch = FugitiveHead()
		return branch !=# '' ? ''.branch : ''
	endif
	return ''
endfunction

