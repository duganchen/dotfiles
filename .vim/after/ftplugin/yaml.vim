setlocal formatprg=prettier\ --stdin\ --parser\ yaml
setlocal makeprg=yamllint\ -f\ parsable\ %
" This is consistent with the default prettier settings.
setlocal expandtab tabstop=2 shiftwidth=2
