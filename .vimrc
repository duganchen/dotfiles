scriptencoding utf-8

" This is mainly for non-neo vim and gvim, using Python 3, on
" OSX and Linux. RipGrep and a NERD font are expected.

if !has('nvim')
	unlet! g:skip_defaults_vim
	source $VIMRUNTIME/defaults.vim
endif

packadd minpac
call minpac#init()
call minpac#add('airblade/vim-gitgutter')
call minpac#add('airblade/vim-rooter')
call minpac#add('cespare/vim-toml')
call minpac#add('chrisbra/Colorizer')
call minpac#add('chriskempson/base16-vim')
call minpac#add('dag/vim-fish')
call minpac#add('euclio/vim-markdown-composer', {'do': '!cargo build --release --no-default-features --features json-rpc'})
call minpac#add('jparise/vim-graphql')
call minpac#add('junegunn/fzf')
call minpac#add('junegunn/fzf.vim')
call minpac#add('junegunn/vim-slash')
call minpac#add('justinmk/vim-dirvish')
call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('luochen1990/rainbow')
call minpac#add('majutsushi/tagbar')
call minpac#add('mbbill/undotree')
call minpac#add('mhinz/vim-sayonara')
call minpac#add('mhinz/vim-startify')
call minpac#add('prabirshrestha/async.vim')`
call minpac#add('prabirshrestha/vim-lsp')
call minpac#add('prabirshrestha/asyncomplete.vim')
call minpac#add('prabirshrestha/asyncomplete-lsp.vim')
call minpac#add('racer-rust/vim-racer')
call minpac#add('ryanoasis/vim-devicons')
call minpac#add('ternjs/tern_for_vim', {'do': '!npm install'})
call minpac#add('thirtythreeforty/lessspace.vim')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-endwise')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-rsi')
call minpac#add('tpope/vim-sleuth')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('w0rp/ale')
call minpac#add('xtal8/traces.vim')

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
set display=lastline
set formatoptions+=j
set hidden
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

nmap <F8> :TagbarToggle<CR>

" Ideas from here:
" https://www.reddit.com/r/vim/comments/4hoa6e/what_do_you_use_for_your_listchars/
let &showbreak = '↪  '
set listchars=tab:\│\ ,extends:›,precedes:‹,nbsp:␣,trail:·,eol:↲

set fillchars=vert:\│

" https://stackoverflow.com/a/16084326/240515
nnoremap <leader>b :ls<cr>:buffer<space>

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

let g:racer_cmd = expand('~/.cargo/bin/racer')

if has('mac')
	let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/'
	"let g:clang_library_path = '/Users/dugan/Qt//Qt Creator.app/Contents/Frameworks/libclang.dylib'
endif

let g:rainbow_active = 1

let g:ale_sign_column_always = 1
let g:ale_linters = {'javascript': ['jshint'], 'python': ['mypy']}
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']

let g:startify_change_to_dir = 0

let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

" For FZF

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" " Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" " Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

nnoremap <c-p> :Files<cr>


augroup autocmds
	autocmd!
	autocmd FileType vifm setlocal filetype=vim
	autocmd FileType bash,sh set makeprg=shellcheck\ -f\ gcc\ %
	autocmd BufEnter,BufNew configure.ac set filetype=m4
	autocmd FileType qf setlocal nobuflisted
	autocmd BufEnter,BufNew .tern_project set ft=json
	autocmd FileType javascript.jsx setlocal expandtab tabstop=2 shiftwidth=2 equalprg=prettier
	autocmd FileType python setlocal foldmethod=indent equalprg=yapf
	autocmd FileType c,cpp setlocal equalprg=clang-format\ -style=file\ -assume-filename=%
	autocmd BufEnter,BufNew *.SlackBuild setlocal filetype=sh shiftwidth=2 expandtab tabstop=4
	autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ %
augroup END

" TMux compatibility
set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[48;2;%lu;%lu;%lum

set termguicolors
set background=dark
colorscheme base16-tomorrow-night
let g:airline_theme='tomorrow'
