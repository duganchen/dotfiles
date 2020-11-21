scriptencoding utf-8

if !isdirectory(expand('~/.cache/vim'))
    call mkdir(expand('~/.cache/vim'))
endif

if filereadable(expand('$VIMRUNTIME/defaults.vim'))
    unlet! g:skip_defaults_vim
    source $VIMRUNTIME/defaults.vim
endif

call plug#begin('~/.vim/plugged')
Plug 'ajmwagar/vim-deus'
Plug 'machakann/vim-highlightedyank'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'justinmk/vim-dirvish'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/vim-slash'
Plug 'tpope/vim-fugitive'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
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

" For airline
set noshowmode
let g:airline_powerline_fonts = 1

set background=dark
set termguicolors
colorscheme deus
highlight NORMAL guibg=NONE
" Needed for redraw issues in both Linux an Mac (Kitty)
set t_ut=

" Install immediately:
"
" CocInstall coc-vimlsp
" CocInstall coc-yaml
" CocInstall coc-json
" CocInstall coc-sh
