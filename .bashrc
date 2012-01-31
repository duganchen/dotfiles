# This is Slackware-specific.
. /etc/profile.d/coreutils-dircolors.sh

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


