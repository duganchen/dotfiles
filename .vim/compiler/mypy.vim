if exists('current_compiler')
  finish
endif
let current_compiler = 'mypy'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:save_cpo = &cpo
set cpo-=C

CompilerSet makeprg=mypy\ --ignore-missing-imports\ %
CompilerSet errorformat=%f:%l:\ %m

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: sw=2 sts=2 et
