scriptencoding utf-8

if !isdirectory(expand('~/.cache/vim'))
    call mkdir(expand('~/.cache/vim'))
endif

if filereadable(expand('$VIMRUNTIME/defaults.vim'))
    unlet! g:skip_defaults_vim
    source $VIMRUNTIME/defaults.vim
endif

call plug#begin('~/.vim/plugged')
Plug 'machakann/vim-highlightedyank'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'joshdick/onedark.vim'
Plug 'justinmk/vim-dirvish'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/vim-slash'
Plug 'tpope/vim-fugitive'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'sainnhe/sonokai'
call plug#end()

" Don't mind if I steal a couple of lines from here:
" https://www.reddit.com/r/neovim/comments/3oeko4/post_your_fzfvim_configurations/cvworyj
nnoremap <silent> <leader>t :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>

set backupdir=~/.cache/vim//
set directory=~/.cache/vim//
set grepprg=rg\ --vimgrep
set hidden
set number
set relativenumber
set smartindent
set undodir=~/.cache/vim//
set undofile

set termguicolors
let g:onedark_terminal_italics=1
colorscheme onedark

" The default status line from vim's help, with plugins.
set statusline=%f 
set statusline+=\ %{WebDevIconsGetFileTypeSymbol()}
set statusline+=\ %{WebDevIconsGetFileFormatSymbol()}    
set statusline+=\ %{fugitive#statusline()}
set statusline+=\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %P%)

" Uncomment these for a transparent background.
" highlight NORMAL guibg=NONE
" set t_ut=

" Install immediately:
"
" CocInstall coc-vimlsp
" CocInstall coc-yaml
" CocInstall coc-json
" CocInstall coc-sh
