" https://stackoverflow.com/a/47316185/240515
setlocal makeprg=flake8\ --select\ F\ %

setlocal formatprg=black\ \--quiet\ -
setlocal expandtab tabstop=4 shiftwidth=4
