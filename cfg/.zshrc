fpath=(~/.zsh/site-functions $fpath)

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.antidote/antidote.zsh
antidote load

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(zoxide init zsh)"

path+=(~/.local/bin)

export LS_COLORS="$(vivid generate catppuccin-macchiato)"

alias l='eza --icons'
alias la='eza --icons --all'
alias ll= 'eza --icons --long'
alias lla='eza --icons --all --long'
alias lt='eza --icons --long --group-directories-first --sort size'

# https://wiki.archlinux.org/title/Color_output_in_console#Using_less
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANROFFOPT="-P -c"

source /home/dugan/.config/broot/launcher/bash/br

source ~/apps/git-subrepo/.rc


# This still seems to be the best (or rather least annoying) history search
source <(fzf --zsh)

export BAT_THEME="Catppuccin Macchiato"
export EDITOR=micro
export MICRO_TRUECOLOR=1
export VISUAL='code --wait'