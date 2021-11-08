# This is meant to be sourced right after the section written by the wizard that runs the first time
# you start Zsh. It sets extendedglob, runs compinit, etc.

# Only other thing: Set ZGEN_RESET_ON_CHANGE to be the path to this file before sourcing it.

# Using this to manage plugins:
# https://github.com/jandamm/zgenom
source "${HOME}/.zgenom/zgenom.zsh"

# Fedora
if [ -f /usr/share/fzf/shell/key-bindings.zsh ]; then
    source /usr/share/fzf/shell/key-bindings.zsh
fi

# OS X
if [ -f /usr/local/opt/fzf/shell/key-bindings.zsh ]; then
    source /usr/local/opt/fzf/shell/key-bindings.zsh
    source /usr/local/opt/fzf/shell/completion.zsh
fi

if ! zgenom saved; then
    zgenom load lincheney/fzf-tab-completion zsh/fzf-zsh-completion.sh
    zgenom load zsh-users/zsh-completions
    zgenom load zsh-users/zsh-autosuggestions
    zgenom load zsh-users/zsh-completions
    zgennom load zdharma-continuum/fast-syntax-highlighting
        
    zgenom save
fi

# My terminals are using OneDark colors.
export BAT_THEME=TwoDark

export MANPAGER=most
export CMAKE_GENERATOR=Ninja
export VISUAL='code --wait'

# These are stolen from oh-my-zsh. Now I can type 49<TAB> and get completions for all files with
# 49 anywhere in their name. Combine this with autosuggestions and I now have what I liked best about
# FISH.
setopt complete_in_word
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# Some options from
# https://github.com/sfischer13/zsh-sensible/blob/master/sensible.zsh
setopt append_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt share_history

# From here:
# https://github.com/junegunn/fzf/issues/1460#issuecomment-635787473
# Note use of https://github.com/sharkdp/fd
export FZF_DEFAULT_COMMAND='fd --type f --color=never'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --color=never"

if [[ $(uname) == "Darwin" ]]; then
    export PATH=$PATH:/Applications/Visual\ Studio\ Code\ 2.app/Contents/Resources/app/bin
fi

# This is Autojump, using nothing but what already comes with ZSH. :)
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
# zstyle ':completion:*:*:cdr:*:*' menu selection
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert always
alias j=cdr

# Apart from ls, these are stolen from Garuda. I'm getting used to them.
# Note the use of the following:
# https://github.com/ogham/exa
# https://github.com/sharkdp/bat
alias cat='bat --style header --style rules --style snip --style changes --style header'
alias hw='hwinfo --short'
alias jctl='journalctl -p 3 -xb'
alias l.="exa -a | egrep '^\.'"
alias la='exa -a --color=always --group-directories-first --icons'
alias ll='exa -l --color=always --group-directories-first --icons'
# alias ls='exa -al --color=always --group-directories-first --icons'
# Using this instead: https://github.com/Peltoche/lsd
alias ls=lsd
alias lt='exa -aT --color=always --group-directories-first --icons'
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

# Prompt. Uses https://starship.rs/
# If this is taking a long time to start on OS X, then make sure you're using git from
# Homebrew. See:
# https://blog.smittytone.net/2021/05/21/how-to-fix-xcodebuild-macos-terminal-slow-downs/
eval $(starship init zsh)
