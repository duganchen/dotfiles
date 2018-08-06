scriptencoding utf-8

" This is mainly for non-neo vim and gvim, using Python 3, on
" OSX and Linux. fd and a NERD font are expected.

if filereadable(expand('$VIMRUNTIME/defaults.vim'))
    unlet! g:skip_defaults_vim
    source $VIMRUNTIME/defaults.vim
endif


" Workaround for jedi-vim on Python 3.7. See:
" https://github.com/davidhalter/jedi-vim/issues/844#issuecomment-404352275
silent! python3 1

packadd minpac
call minpac#init()
call minpac#add('Shougo/deoplete.nvim')
call minpac#add('Shougo/neco-vim')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('airblade/vim-rooter')
call minpac#add('autozimu/LanguageClient-neovim', {'do': {->system('bash install.sh')}})
call minpac#add('arcticicestudio/nord-vim', {'type': 'opt'})
call minpac#add('chrisbra/Colorizer')
call minpac#add('ctrlpvim/ctrlp.vim', {'type': 'opt'})
call minpac#add('dag/vim-fish')
call minpac#add('junegunn/fzf', {'type': 'opt'})
call minpac#add('junegunn/fzf.vim', {'type': 'opt'})
call minpac#add('junegunn/gv.vim')
call minpac#add('junegunn/vim-slash')
call minpac#add('justinmk/vim-dirvish')
call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('luochen1990/rainbow')
call minpac#add('majutsushi/tagbar')
call minpac#add('mhinz/vim-startify')
call minpac#add('morhetz/gruvbox', {'type': 'opt'})
call minpac#add('nixprime/cpsm', {'type': 'opt', 'do': {->system('env PY3=ON ./install.sh')}})
call minpac#add('roxma/nvim-yarp')
call minpac#add('roxma/vim-hug-neovim-rpc')
call minpac#add('ryanoasis/vim-devicons')
call minpac#add('thirtythreeforty/lessspace.vim')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-dispatch')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-rhubarb')
call minpac#add('tpope/vim-sleuth')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('vim-airline/vim-airline')
call minpac#add('w0rp/ale')
call minpac#add('zchee/deoplete-clang')
call minpac#add('zchee/deoplete-jedi')

packadd! matchit

if has('gui_running')
    packadd! ctrlp.vim
    packadd! cpsm
    packadd! gruvbox
else
    packadd! fzf
    packadd! fzf.vim
    packadd! nord-vim
endif

set autoindent
set autoread

" If you're having trouble on OS X, try building vim without --with-client-server.
" https://github.com/spf13/spf13-vim/issues/1018#issuecomment-287197190
set clipboard^=unnamedplus,unnamed

" Correct on Linux. Correct on OS X, AFAIK
if !has('nvim')
    set ttymouse=xterm2
endif

if !isdirectory(expand('~/.cache/vim'))
    call mkdir(expand('~/.cache/vim'))
endif
set backupdir=~/.cache/vim//
set directory=~/.cache/vim//
set undodir=~/.cache/vim//

" GitHub's desktop-browser web interface can display 127 characters per line without a horizontal scrollbar.
set colorcolumn=+1
set textwidth=127

set complete-=i
set display=lastline
set formatoptions+=j
set hidden
set infercase
set linebreak
set noshowmode
set number
set relativenumber
set sessionoptions-=options
set completeopt-=preview
set omnifunc=syntaxcomplete#Complete
set grepprg=rg\ --vimgrep
set shell=bash
set showmatch
set smartcase
set ttyfast
set undofile
set viminfo^=!
set visualbell
set wildignore+=*.pyc,*.o,*/.git/*,*/build/*,*.swp,*/.svn,*/.hg
set nowrap

" Ideas from here:
" https://www.reddit.com/r/vim/comments/4hoa6e/what_do_you_use_for_your_listchars/
let &showbreak = '↪  '
set listchars=tab:\│\ ,extends:›,precedes:‹,nbsp:␣,trail:·,eol:↲

set fillchars=vert:\│

let g:rainbow_active = 1

" I use ctags as intended, gtags for cscope. This works well for most languages.
set cscopeprg=gtags-cscope

let g:deoplete#enable_at_startup = 1

if has('mac')
    let g:deoplete#sources#clang#libclang_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib'
    " Or expand('~/Qt/Qt Creator.app/Contents/Frameworks/libclang.dylib')
    " Or /usr/local/opt/llvm/lib/libclang.dylib
endif


" For most C++ projects, make a CMake file and then use it to generate
" a compile_commands.json. Add compile_commands.json to .gitignore.
" cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=On
" Both deoplete-clang and clangd will recognize it.
" On OS X, this works for me for Qt:
" env CMAKE_PREFIX_PATH=~/Qt/5.10.1/clang_64/lib/cmake/Qt5 cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=On

let g:LanguageClient_serverCommands = {
    \'python': ['pyls'],
    \'c': ['clangd'],
    \'cpp': ['clangd'],}
let g:ale_linters_explicit = 1
let g:ale_linters = {
    \'sh': ['shellcheck'],
    \'vim': ['vint']}

let g:startify_change_to_dir = 0

let g:airline_powerline_fonts = 1

if has('gui_running')
    let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
    nnoremap <leader>b :CtrlPBuffer<cr>
    let g:ctrlp_user_command = {
        \'types': {
            \1: ['.git', 'cd %s && git ls-files']
        \},
        \'fallback': 'fd --type f --color=never "" %s'
    \}
    let g:ctrlp_use_caching = 0
else
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
    nnoremap <leader>t :GitFiles<cr>
    nnoremap <leader>b :Buffers<cr>
endif

augroup autocmds
    autocmd!
    autocmd FileType vifm setlocal filetype=vim
    autocmd BufEnter,BufNew configure.ac set filetype=m4
    autocmd FileType qf setlocal nobuflisted
    autocmd BufEnter,BufNew .tern_project set ft=json
    autocmd BufEnter,BufNew *.SlackBuild setlocal filetype=sh shiftwidth=2 expandtab tabstop=4
    autocmd BufEnter,BufNew *.info call CheckSlackBuildInfo()
    autocmd FileType markdown setlocal wrap textwidth=0

    if !empty('$tmux') && !has('gui_running')
        " Open a TMux split to show live rendered previews in Lynx. Gist is here:
        " https://gist.github.com/duganchen/32a5ca43bf309b2eed61f70615ab8c7a
        autocmd BufNewFile,BufReadPost *.html,*.md,*.rst,*.tex call StartPreview()
        autocmd TextChanged,TextChangedI *.html,*.md,*.rst,*.tex call UpdatePreview()
        autocmd BufUnload *.html,*.md,*.rst,*.tex call StopPreview()
    endif
augroup END

function! CheckSlackBuildInfo()
    if filereadable(expand('%:p:r'). '.SlackBuild')
        setlocal filetype=sh
    endif
endfunction

function! DeleteHiddenBuffers()
    "https://stackoverflow.com/a/30101152/240515
    let l:tpbl=[]
    let l:closed = 0
    call map(range(1, tabpagenr('$')), 'extend(l:tpbl, tabpagebuflist(v:val))')
    for l:buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(l:tpbl, v:val)==-1')
        if getbufvar(l:buf, '&mod') == 0
            silent execute 'bwipeout' l:buf
            let l:closed += 1
        endif
    endfor
    echo 'Closed '.l:closed.' hidden buffers'
endfunction

" https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/cliuz1o/
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

nmap <F8> :TagbarToggle<CR>

" TMux compatibility
set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[48;2;%lu;%lu;%lum

if has('gui_running')
    colorscheme gruvbox
else
    set termguicolors
    let g:nord_italic = 1
    let g:nord_italic_comments = 1
    set background=dark
    colorscheme nord
endif
