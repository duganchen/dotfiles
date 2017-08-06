scriptencoding utf-8

" This is mainly for non-neo vim and gvim, using Python 3, on
" OSX and Linux. RipGrep and a NERD font are expected.

if !has('nvim')
	unlet! g:skip_defaults_vim
	source $VIMRUNTIME/defaults.vim
endif

call plug#begin()
Plug 'Rip-Rip/clang_complete'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'ajh17/VimCompletesMe'
Plug 'arcticicestudio/nord-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'davidhalter/jedi-vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/vim-slash'
Plug 'justinmk/vim-dirvish'
Plug 'ludovicchabant/vim-gutentags'
Plug 'luochen1990/rainbow'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'nixprime/cpsm', {'do': 'env PY3=ON ./install.sh'}
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'ternjs/tern_for_vim', {'do': 'npm install'}
Plug 'thirtythreeforty/lessspace.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'w0rp/ale'
call plug#end()

set autoindent
set autoread

if has('mac')
	set clipboard=unnamed
else
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
set hidden
set laststatus=2
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
set viminfo^=!
set visualbell
set wildignore+=*.pyc,*.o,*/.git/*,*/build/*,*.swp,*/.svn,*/.hg
set nowrap

nmap <F8> :TagbarToggle<CR>

" Ideas from here:
" https://www.reddit.com/r/vim/comments/4hoa6e/what_do_you_use_for_your_listchars/
let &showbreak = '↪  '
set listchars=tab:\│\ ,extends:›,precedes:‹,nbsp:␣,trail:·,eol:↲
let &fillchars='vert: ,fold: '

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

function! LightlineFiletype()
	return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! LightlineFileformat()
	return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! LightlineReadonly()
	if &filetype ==# 'help'
		return ''
	elseif &readonly
		return ''
	else
		return ''
	endif
endfunction

function! LightlineFugitive()
	if expand('%:t') =~# 'Tagbar'
		return ''
	endif

	let l:status = fugitive#statusline()
	if l:status ==# ''
		return l:status
	endif

	" [Git:6733b9bc(master)]
	let l:start = stridx(l:status, ':')
	let l:end = stridx(l:status, ']')
	if l:start == -1
		" [Git(master)]
		let l:start = stridx(l:status, '(')
		let l:end = stridx(l:status, ')')
	endif
	return ' '. strpart(l:status, l:start + 1, l:end - l:start - 1)
endfunction

function! LightlineMode()
	let l:fname = expand('%:t')

	if l:fname =~# 'Tagbar'
		return 'Tagbar'
	endif

	if l:fname ==# 'ControlP'
		return 'CtrlP'
	endif

	return lightline#mode()
endfunction

function! LightlineModified()
	if &filetype ==# 'help'
		return ''
	elseif &modified
		return '+'
	else
		return ''
	endif
endfunction


function! LightlineFilename()
	let l:fname = expand('%:t')
	let l:nr = bufnr('')

	if l:fname ==# 'ControlP'
		return g:lightline.ctrlp_item
	endif

	if l:fname =~# 'Tagbar'
		return g:lightline.fname
	endif

	if l:fname ==# ''
		return l:nr . ':' . '[No Name]'
	endif

	return l:nr . ':' . l:fname
endfunction

function! CtrlPMark()
	if expand('%:t') =~# 'ControlP' && has_key(g:lightline, 'ctrlp_item')
		call lightline#link('iR'[g:lightline.ctrlp_regex])
		return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
					\ , g:lightline.ctrlp_next], 0)
	else
		return ''
	endif
endfunction

let g:ctrlp_status_func = {
			\ 'main': 'CtrlPStatusFunc_1',
			\ 'prog': 'CtrlPStatusFunc_2',
			\ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
	let g:lightline.ctrlp_regex = a:regex
	let g:lightline.ctrlp_prev = a:prev
	let g:lightline.ctrlp_item = a:item
	let g:lightline.ctrlp_next = a:next
	return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
	return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
	let g:lightline.fname = a:fname
	return lightline#statusline(0)
endfunction

let g:lightline = {
	\'component': {
		\'lineinfo': ' %3l:%-2v',
	\},
	\'component_function': {
		\'ctrlpmark': 'CtrlPMark',
		\'filetype': 'LightlineFiletype',
		\'fileformat': 'LightlineFileformat',
		\'filename': 'LightlineFilename',
		\'mode': 'LightlineMode',
		\'modified': 'LightlineModified',
		\'readonly': 'LightlineReadonly',
		\'fugitive': 'LightlineFugitive',
		\'gutentags': 'gutentags#statusline',
		\'sleuth': 'SleuthIndicator',
		\'ale': 'ale#statusline#Status',
	\},
	\'active': {
		\'left': [  [ 'mode', 'paste' ], [ 'readonly', 'fugitive', 'filename', 'modified' ] , [ 'ctrlpmark' ] ],
		\'right': [ [ 'sleuth', 'gutentags', 'lineinfo', 'ale' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ],
	\}
\}

" Having trouble with these on a Mac right now.
if has('unix') && !has('mac')
	let g:lightline.separator = { 'left': '', 'right': '' }
	let g:lightline.subseparator = { 'left': '', 'right': '' }
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
let g:ale_linters = {'javascript': ['eslint'], 'python': ['mypy'], 'bash': []}
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']

let g:startify_change_to_dir = 0

augroup autocmds
	autocmd!
	autocmd FileType vifm setlocal filetype=vim
	autocmd FileType bash,sh set makeprg=shellcheck\ -f\ gcc\ %
	autocmd BufEnter,BufNew configure.ac set filetype=m4
	autocmd FileType qf setlocal nobuflisted
	autocmd BufEnter,BufNew .tern_project set ft=json
	autocmd FileType javascript.jsx setlocal expandtab tabstop=2 shiftwidth=2
	autocmd FileType python setlocal foldmethod=indent equalprg=yapf
	autocmd FileType c,cpp setlocal equalprg=clang-format
	autocmd filetype c,cpp setlocal equalprg=clang-format\ -style=file -assume-filename=%
augroup END

" TMux compatibility
set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[48;2;%lu;%lu;%lum

set termguicolors
set background=dark
let g:nord_italic_comments = 1
colorscheme nord
let g:lightline.colorscheme = 'nord'
