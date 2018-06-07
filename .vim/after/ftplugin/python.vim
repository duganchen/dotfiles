setlocal foldmethod=indent equalprg=yapf makeprg=mypy\ --show-column-numbers\ %
let &l:errorformat = '%f:%l:%c:%t:%m,%f:%l:%t:%m'
