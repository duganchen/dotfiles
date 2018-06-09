" https://github.com/sharat87/lawn/blob/master/vim/after/compiler/jshint.vim
setlocal equalprg=prettier makeprg=jshint\ --verbose\ %\ \\\|\ head\ -n-2 errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %m\ (%t%n)

