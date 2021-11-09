# This is meant to be sourced right after the section written by the wizard that runs the first time
# you start Zsh. It sets extendedglob, runs compinit, etc.

# Only other thing: Set ZGEN_RESET_ON_CHANGE to be the path to this file before sourcing it.

# Using this to manage plugins:
# https://github.com/jandamm/zgenom
source "${HOME}/.zgenom/zgenom.zsh"

# OS X
if [ -f /usr/local/opt/fzf/shell/key-bindings.zsh ]; then
    source /usr/local/opt/fzf/shell/key-bindings.zsh
    source /usr/local/opt/fzf/shell/completion.zsh
fi

if ! zgenom saved; then
    zgenom load Aloxaf/fzf-tab
    zgenom load zsh-users/zsh-completions
    zgenom load zsh-users/zsh-autosuggestions
    zgenom load zsh-users/zsh-completions
    zgenom load zdharma-continuum/fast-syntax-highlighting
    zgenom save
fi

# Prompt. Uses https://starship.rs/
# If this is taking a long time to start on OS X, then make sure you're using git from
# Homebrew. See:
# https://blog.smittytone.net/2021/05/21/how-to-fix-xcodebuild-macos-terminal-slow-downs/
eval $(starship init zsh)
