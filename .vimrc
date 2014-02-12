call pathogen#infect()
Helptags

filetype plugin indent on
syntax enable

" http://vim.wikia.com/wiki/Remove_unwanted_spaces
autocmd BufWritePre * :%s/\s\+$//e

" We don't want the default filetype to be text.
autocmd BufEnter * if &filetype == "" | setlocal ft=unknown | endif

set autoindent encoding=utf-8 hlsearch incsearch laststatus=2 mouse=a nospell number nobackup nocompatible noerrorbells noignorecase noswapfile omnifunc=syntaxcomplete#Complete ruler smartcase shiftwidth=4 showcmd showmatch showmode softtabstop=4 smarttab t_Co=256 tabstop=4 textwidth=0 title ttyfast visualbell wildmenu wrap

autocmd FileType html,markdown,plaintex,tex,text set spell spelllang=en_ca
autocmd FileType coffee,haskell,javascript,python,ruby setlocal expandtab
autocmd FileType python setlocal colorcolumn=80 foldlevel=99 foldmethod=indent
autocmd FileType text setlocal colorcolumn=73 ignorecase noexpandtab textwidth=72
autocmd FileType c,cpp,cs,java,objc,php setlocal cindent
autocmd FileType javascript setlocal foldlevel=0
autocmd FileType snippet setlocal noexpandtab nospell
autocmd BufReadPost fugitive://* set bufhidden=delete


let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

let g:syntastic_c_compiler = 'clang'
let g:syntastic_cpp_compiler = 'clang++'

" Syntastic assumes C++11 support.
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_cpp_config_file = '.syntastic_cpp_config'

let g:virtualenv_stl_format = '[%n]'

set statusline=%n\ %f\ %y\ %R\ %m\ %#warningmsg#%{SyntasticStatuslineFlag()}%*\ %{fugitive#statusline()}%{virtualenv#statusline()}%=%l/%L,%c

" set statusline=%n\ %f\ %y\ %R\ %m\ %#warningmsg#%{SyntasticStatuslineFlag()}%*\ %{fugitive#statusline()}%=%l/%L,%c

color molokai

" The rest is copy and pasted from Shougo.

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

" au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


" let g:syntastic_cpp_include_dirs = [ '/usr/include/SDL2' ]
