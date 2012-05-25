export LS_OPTIONS="${LS_OPTIONS} --group-directories-first --human-readable"
alias du='du -h'
alias df='df -h'

# I use some of Roman's bash config. Not all of it:

# The OS we are currently using
platform=`uname`

modules="$HOME/.bash/modules"
# == General colors to use on the terminal
source $modules/colors.sh
# == Pimped prompt
source $modules/prompt.sh
# == Git Completion utility
source $modules/git-completion.sh

# Set up the LS_COLORS environment:
if [ -f $HOME/.dir_colors ]; then
  eval `/bin/dircolors -b $HOME/.dir_colors`
fi

