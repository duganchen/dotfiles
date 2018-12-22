" From:
" https://github.com/nthapaliya/dotfiles/blob/master/home/.config/nvim/init.vim
function! Fish_indent(buffers)
  return {
  \ 'command': 'fish_indent -w %t',
  \ 'read_temporary_file': 1,
  \ 'suggested_filetypes': ['fish']
  \ }
endfunction

let g:ale_fixers = {'fish': ['Fish_indent']}
