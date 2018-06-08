" https://github.com/Kuniwak/vint-syntastic/blob/master/syntax_checkers/vim/vint.vim
setlocal makeprg=vint\ %
let &l:errorformat = '%W%f:%l:%c: %m%Z'
