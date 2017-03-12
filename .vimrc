if !has('nvim')
	unlet! skip_defaults_vim
	source $VIMRUNTIME/defaults.vim
endif

call plug#begin()
Plug 'Rip-Rip/clang_complete'
Plug 'ajh17/VimCompletesMe'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'davidhalter/jedi-vim'
Plug 'drgarcia1986/python-compilers.vim'
Plug 'itchyny/lightline.vim'
Plug 'jeetsukumaran/vim-filebeagle'
Plug 'junegunn/vim-slash'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
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
set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m
set shell=bash
set shiftwidth=4
set smartcase
set smarttab
set softtabstop=4
set tabstop=4
set ttyfast
set viminfo^=!
set path=.,**
set visualbell
set wildignore+=*.pyc,*.o
set nowrap

nmap <F8> :TagbarToggle<CR>
nnoremap <leader>be :ls<cr>:b<space>

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
	\},
\}

if has("mac")
	let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib'
end

augroup autocmds
	autocmd!
	autocmd FileType vifm set filetype=vim
	autocmd BufEnter,BufNew configure.ac set filetype=m4
augroup END

set background=dark
colorscheme koehler
