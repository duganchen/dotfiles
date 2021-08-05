# Additional setup after what the plugin manager does. My setup is oh-my-zsh with no prompt
# and
# plugins=(git colored-man-pages fzf zsh-completions history-substring-search zsh-autosuggestions zsh-syntax-highlighting)

autoload -U compinit && compinit

export CMAKE_GENERATOR=Ninja

export VISUAL='code --wait'

if [[ $(uname) == "Darwin" ]]; then
    export PATH=$PATH:/Applications/Visual\ Studio\ Code\ 2.app/Contents/Resources/app/bin
fi

# FINALLY managed to get something resembling FISH's awesome cd'ing...

# AFAIK ZSH's completinword option already takes care of what I want from the following,
# and Oh My ZSH sets it?
# https://scriptingosx.com/2019/07/moving-to-zsh-part-5-completions/
# zstyle ':completion:*' list-suffixeszstyle ':completion:*' expand prefix suffix

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':completion:*:*:cdr:*:*' menu selection
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both
alias cd=cdr

# Apart from ls, these are stolen from Garuda. I'm getting used to them.
alias cat='bat --style header --style rules --style snip --style changes --style header'
alias hw='hwinfo --short'
alias jctl='journalctl -p 3 -xb'
alias l.="exa -a | egrep '^\.'"
alias la='exa -a --color=always --group-directories-first --icons'
alias ll='exa -l --color=always --group-directories-first --icons'
# alias ls='exa -al --color=always --group-directories-first --icons'
alias ls=lsd
alias lt='exa -aT --color=always --group-directories-first --icons'
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

if [[ $(uname) == "Darwin" ]]; then
    # Path resolution seems to trigger a slow xcodebuild operation
    # on OS X...
    eval $(/usr/local/bin/starship init zsh)
else
    eval $(starship init zsh)
fi

# I seem to recall FISH having something like this.
setopt glob_complete