# Some ideas from here:
# https://www.olets.dev/posts/zsh-config-productivity-plugins-for-mac-oss-default-shell/
# History[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history
setopt share_history
# Changing directories
setopt auto_cd
setopt auto_pushd
unsetopt pushd_ignore_dups
setopt pushdminus
# Completion
setopt auto_menu
setopt always_to_end
setopt complete_in_word
unsetopt flow_control
unsetopt menu_complete
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path
zstyle ':completion:*' list-colors ''

# This doesn't work.
# zstyle ':completion:*:*:kill:*:processes'
# list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
# Other
setopt prompt_subst

# And my stuff
export EDITOR=micro
export VISUAL='code --wait'

# I was going to use https://github.com/mattmc3/zshrc.d
# but ended up not bothering

source ~/.zsh/lscolors.sh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [[ -f /usr/share/fzf/shell/key-bindings.zsh ]]; then
    source /usr/share/fzf/shell/key-bindings.zsh
fi

if [[ -f /usr/local/opt/fzf/shell/key-bindings.zsh ]]; then
    source /usr/local/opt/fzf/shell/key-bindings.zsh
fi

# Ubuntu
if [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
    source /usr/share/doc/fzf/examples/key-bindings.zsh
fi

# I don't actually use ZOxide, but it seems to be the best of the cd-history things
eval "$(zoxide init zsh)"

eval "$(starship init zsh)"

export PATH=$PATH:$HOME/.local/bin
if [[ -d /Applications ]]; then
    export PATH=$PATH:/Applications/Visual\ Studio\ Code\ 2.app/Contents/Resources/app/bin
fi
# On Ubuntu you also want /usr/lib/cargo/bin in the PATH, for fd-find.

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# For ZSH, I'm not going to make any assumptions about colors, icons or
# fonts. Note that unlike their FISH counterparts, these don't assume a NERD font.
alias l='exa --classify'
alias la='exa --classify --all'
alias lt='exa --classify --long --group-directories-first --sort size'
alias tree='exa --classify -T'

if [[ "$(uname)" == "Darwin" ]]; then
    alias ls='gls --classify --color=auto'
fi
