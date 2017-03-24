" This is mainly for non-neo vim and gvim, using Python 3, on
" OSX and Linux. RipGrep and a patch NERD font are expected.

if !has('nvim')
	unlet! skip_defaults_vim
	source $VIMRUNTIME/defaults.vim
endif

call plug#begin()
Plug 'Rip-Rip/clang_complete'
Plug 'ajh17/VimCompletesMe'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'davidhalter/jedi-vim'
Plug 'drgarcia1986/python-compilers.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/vim-slash'
Plug 'justinmk/vim-dirvish'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'neomake/neomake'
Plug 'nixprime/cpsm', {'do': 'env PY3=ON ./install.sh'}
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'ryanoasis/vim-devicons'
call plug#end()

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

let g:gutentags_cache_dir = $HOME . "/.cache/vim"

" GitHub's desktop-browser web interface can display 137 characters per line without a horizontal scrollbar.
set colorcolumn=138
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
set shiftwidth=4
set smartcase
set smarttab
set softtabstop=4
set tabstop=4
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

" http://vimcasts.org/episodes/bubbling-text/ using unimpaired
if has("osx")
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

function! MyFilename()
	return bufnr('%') . ':' . fnamemodify(expand('%:p'), ':~:.')
endfunction

function! MyFiletype()
	return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
	return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! LightlineReadonly()
	if &filetype == "help"
		return ""
	elseif &readonly
		return ''
	else
		return ""
	endif
endfunction

function! LightlineFugitive()
	if exists('*fugitive#head')
		let branch = fugitive#head()
		return branch !=# '' ? ' '.branch : ''
	endif
	return ''
endfunction

let g:lightline = {
	\'component': {
		\'lineinfo': ' %3l:%-2v',
	\},
	\'component_function': {
		\'filename': 'MyFilename',
		\'filetype': 'MyFiletype',
		\'fileformat': 'MyFileformat',
		\'readonly': 'LightlineReadonly',
		\'fugitive': 'LightlineFugitive',
	\},
	\'active': {
		\'left': [  [ 'mode', 'paste' ], [ 'readonly', 'fugitive', 'filename', 'modified' ] ],
	\}
\}

" Having trouble with these on a Mac right now.
if has('unix') && !has('mac')
	let g:lightline.separator = { 'left': '', 'right': '' }
	let g:lightline.subseparator = { 'left': '', 'right': '' }
endif

if has("mac")
	let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib'
end

" For startify. From the vim-devicons README
let entry_format = "'   ['. index .']'. repeat(' ', (3 - strlen(index)))"
if exists('*WebDevIconsGetFileTypeSymbol')  " support for vim-devicons
	let entry_format .= ". WebDevIconsGetFileTypeSymbol(entry_path) .' '.  entry_path"
else
	let entry_format .= '. entry_path'
endif

let g:ctrlp_user_command = {
	\'types': {
		\1: ['.git', 'cd %s && git ls-files'],
		\2: ['.hg', 'hg --cwd %s locate -I .'],
	\},
\} 
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader>o :CtrlPMRUFiles<cr>
if executable('rg')
	let g:ctrlp_user_command.fallback = 'rg %s --files --color=never --glob ""'
elseif executable('ag')
	let g:ctrlp_user_command.fallback = 'ag %s -l --nocolor -g ""'
else
	let g:ctrlp_user_command.fallback = 'find %s -type f'
end
let g:ctrlp_use_caching = 0

augroup autocmds
	autocmd!
	autocmd FileType vifm set filetype=vim
	autocmd FileType bash,sh set makeprg=shellcheck\ -f\ gcc\ %
	autocmd BufEnter,BufNew configure.ac set filetype=m4
augroup END

set background=dark
" Idea is:
" evening for opaque backgrounds,
" koheler for transparent backgrounds
if has('gui') || &termguicolors
	colorscheme evening
else
	colorscheme koehler
endif
