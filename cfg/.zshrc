# This is intended for Ubuntu VMs and their default purple terminals. I've
# found that under these conditions, it's actually very difficult to get a
# Zsh setup that's both worth using (with an appreciably better user experience
# than BASH and performant (not appreciably slower than BASH).

HISTFILE=~/.zsh_history      # Location of history file
HISTSIZE=10000               # Number of lines kept in memory
SAVEHIST=10000               # Number of lines saved to file

autoload -Uz compinit && compinit

# This is where order matters. fzf-tab goes after compinit, but before
# zsh-autosuggestions
source ~/.zsh/fzf-tab/fzf-tab.plugin.zsh

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# This looks good with a Yaru terminal. The Pure prompt certainly does not.
source ~/.zsh/spaceship-prompt/spaceship.zsh

# From Ubuntu's BASH setup
export CLICOLOR=1
alias ls='ls --color=auto'

# My additions

if whence -p zoxide > /dev/null ; then
  eval "$(zoxide init zsh)"
fi

if whence -p fzf > /dev/null ; then
  source <(fzf --zsh)
fi

if [ -f ~/.zsh/zshrc-local ]; then
  source ~/.zsh/local.zsh
fi

if [ -f ~/.config/broot/launcher/bash/br ]; then
  source ~/.config/broot/launcher/bash/br
fi
