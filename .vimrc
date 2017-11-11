scriptencoding utf-8

" This is mainly for non-neo vim and gvim, using Python 3, on
" OSX and Linux. RipGrep and a NERD font are expected.

if !has('nvim')
	unlet! g:skip_defaults_vim
	source $VIMRUNTIME/defaults.vim
endif

packadd minpac
call minpac#init()
call minpac#add('Rip-Rip/clang_complete')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('airblade/vim-rooter')
call minpac#add('chrisbra/Colorizer')
call minpac#add('ctrlpvim/ctrlp.vim')
call minpac#add('dag/vim-fish')
call minpac#add('davidhalter/jedi-vim')
call minpac#add('dracula/vim')
call minpac#add('euclio/vim-markdown-composer', {'do': '!cargo build --release --no-default-features --features json-rpc'})
call minpac#add('junegunn/vim-slash')
call minpac#add('justinmk/vim-dirvish')
call minpac#add('lifepillar/vim-mucomplete')
call minpac#add('ludovicchabant/vim-gutentags')
call minpac#add('luochen1990/rainbow')
call minpac#add('majutsushi/tagbar')
call minpac#add('mbbill/undotree')
call minpac#add('mhinz/vim-startify')
call minpac#add('nixprime/cpsm', {'do': {->system('env PY3=ON ./install.sh')}})
call minpac#add('ryanoasis/vim-devicons')
call minpac#add('ternjs/tern_for_vim', {'do': '!npm install'})
call minpac#add('thirtythreeforty/lessspace.vim')
call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-endwise')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-rsi')
call minpac#add('tpope/vim-sleuth')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('vim-airline/vim-airline')
call minpac#add('w0rp/ale')

set autoindent
set autoread

if !has('mac')
	set clipboard^=unnamedplus,unnamed
endif

set infercase

" Correct on Linux. Correct on OS X, AFAIK
if !has('nvim')
	set ttymouse=xterm2
endif

" Make sure this directory exists.
set backupdir=~/.cache/vim//
set directory=~/.cache/vim//
set undodir=~/.cache/vim//

let g:gutentags_cache_dir = $HOME . '/.cache/vim'

" GitHub's desktop-browser web interface can display 137 characters per line without a horizontal scrollbar.
set colorcolumn=+1
set textwidth=137

set complete-=i
set cscopetag
set display=lastline
set formatoptions+=j
set noshowmode
set number
set relativenumber
set sessionoptions-=options
set completeopt-=preview
set omnifunc=syntaxcomplete#Complete
if executable('rg')
	set grepprg=rg\ --vimgrep
elseif executable('ag')
	set grepprg=ag\ --vimgrep
endif
set shell=bash
set showmatch
set smartcase
set ttyfast
set undofile
set viminfo^=!
set visualbell
set wildignore+=*.pyc,*.o,*/.git/*,*/build/*,*.swp,*/.svn,*/.hg
set nowrap

" For MUcomplete
set completeopt+=menuone,noinsert,noselect
set shortmess+=c
set belloff+=ctrlg
let g:mucomplete#enable_auto_at_startup = 1

nmap <F8> :TagbarToggle<CR>

" Ideas from here:
" https://www.reddit.com/r/vim/comments/4hoa6e/what_do_you_use_for_your_listchars/
let &showbreak = '↪  '
set listchars=tab:\│\ ,extends:›,precedes:‹,nbsp:␣,trail:·,eol:↲

set fillchars=vert:\│

" http://vimcasts.org/episodes/bubbling-text/ using unimpaired
if has('osx')
	" Alt+k and Alt+j bubble up on OS X. This works in iterm2.
	nmap ˚ [e
	nmap ∆ ]e
	vmap ˚ [egv
	vmap ∆ ]egv
else
	" Escape sequences are the same key sequences on my MacBook Pro keyboard
	nmap [A [e
	nmap [B ]e
	vmap [A [egv
	vmap [B ]egv
	nmap <C-Up> [e
	nmap <C-Down> ]e
	vmap <C-Up> [egv
	vmap <C-Down> ]egv
endif

if has('mac')
	let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib'
end

let g:ctrlp_user_command = {
	\'types': {
		\1: ['.git', 'cd %s && git ls-files'],
		\2: ['.hg', 'hg --cwd %s locate -I .'],
	\},
\}
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
nnoremap <leader>o :CtrlPMRUFiles<cr>
nnoremap <leader>b :CtrlPBuffer<cr>
if executable('rg')
	let g:ctrlp_user_command.fallback = 'rg %s --files --color=never --glob ""'
elseif executable('ag')
	let g:ctrlp_user_command.fallback = 'ag %s -l --nocolor -g ""'
else
	let g:ctrlp_user_command.fallback = 'find %s -type f'
end
let g:ctrlp_mruf_exclude = '.*/tmp/.*\|.*/.git/.*'
let g:ctrlp_clear_cache_on_exit = 1

let g:rainbow_active = 1

let g:ale_sign_column_always = 1
let g:ale_linters = {'javascript': ['eslint'], 'python': ['mypy']}
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']

let g:startify_change_to_dir = 0

let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

augroup autocmds
	autocmd!
	autocmd FileType vifm setlocal filetype=vim
	autocmd FileType bash,sh set makeprg=shellcheck\ -f\ gcc\ %
	autocmd BufEnter,BufNew configure.ac set filetype=m4
	autocmd FileType qf setlocal nobuflisted
	autocmd BufEnter,BufNew .tern_project set ft=json
	autocmd FileType javascript.jsx setlocal expandtab tabstop=2 shiftwidth=2 equalprg=prettier
	autocmd FileType python setlocal foldmethod=indent equalprg=yapf
	autocmd filetype c,cpp setlocal equalprg=clang-format\ -style=file\ -assume-filename=%
augroup END

" TMux compatibility
set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[48;2;%lu;%lu;%lum

set termguicolors
colorscheme dracula
