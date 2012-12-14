setopt promptsubst
setopt promptpercent

alias du='du -h'
alias df='df -h'
alias ls='ls --color=auto --group-directories-first --human-readable'

PROMPT=$'%n@%m %{\e[1;31m%}%~\n%{\e[1;32m%}$%{\e[0m%} '

# Not done automatically on all distributions.
eval `dircolors -b ~/.dir_colors`

export TERM=xterm-256color
