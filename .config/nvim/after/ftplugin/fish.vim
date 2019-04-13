let b:ale_linters_explicit = 1
let b:ale_linters = ['fish']

" Stolen from:
" https://github.com/nthapaliya/dotfiles/blob/master/home/.config/nvim/init.vim
function! Fish_indent(buffers)
  return {
  \ 'command': 'fish_indent -w %t',
  \ 'read_temporary_file': 1,
  \ 'suggested_filetypes': ['fish']
  \ }
endfunction
let b:ale_fixers= {'fish': ['Fish_indent']}

let b:ale_fix_on_save = 1

" fish_indent indents with 4 spaces, and most of what's included with FISH fits that format, but there are still inconsistencies.
" See, for example,
" https://github.com/fish-shell/fish-shell/issues/1472
setlocal expandtab tabstop=4 shiftwidth=4


