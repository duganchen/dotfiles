export LS_OPTIONS="${LS_OPTIONS} --group-directories-first --human-readable"
alias du='du -h'
alias df='df -h'

# I use some of Roman's bash config. Not all of it:

# The OS we are currently using
platform=`uname`

mymodules="$HOME/.bash/modules"
# == General colors to use on the terminal
source $mymodules/colors.sh
# == Pimped prompt
source $mymodules/prompt.sh
# == Git Completion utility
source $mymodules/git-completion.sh

# Not done automatically on all distributions.
eval `dircolors -b ~/.dir_colors`

export TERM=xterm-256color
