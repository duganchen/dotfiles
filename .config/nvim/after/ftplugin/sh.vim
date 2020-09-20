" This is what SlackBuilds expect.
setlocal expandtab tabstop=2 shiftwidth=2

setlocal makeprg=shellcheck\ -f\ gcc\ %
setlocal formatprg=shfmt
