setlocal makeprg=clang\ %
setlocal equalprg=clang-format\ -style=file\ -assume-filename=%
let &l:errorformat = '%E%f:%l:%c: fatal error: %m,' .
            \ '%E%f:%l:%c: error: %m,' .
            \ '%W%f:%l:%c: warning: %m,' .
            \ '%-G%\m%\%%(LLVM ERROR:%\|No compilation database found%\)%\@!%.%#,' .
            \ '%E%m'
