# This is Slackware-specific.
. /etc/profile.d/coreutils-dircolors.sh

export LS_OPTIONS="${LS_OPTIONS} --group-directories-first --human-readable"
alias du='du -h'
alias df='df -h'
