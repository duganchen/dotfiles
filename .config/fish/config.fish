# Current using base16-bright.

# This, except for leaving the background transparent:
# https://github.com/nicodebo/base16-fzf/blob/master/fish/base16-bright.fish

set -l color00 '#000000'
set -l color01 '#303030'
set -l color02 '#505050'
set -l color03 '#b0b0b0'
set -l color04 '#d0d0d0'
set -l color05 '#e0e0e0'
set -l color06 '#f5f5f5'
set -l color07 '#ffffff'
set -l color08 '#fb0120'
set -l color09 '#fc6d24'
set -l color0A '#fda331'
set -l color0B '#a1c659'
set -l color0C '#76c7b7'
set -l color0D '#6fb3d2'
set -l color0E '#d381c3'
set -l color0F '#be643c'
set -x FZF_DEFAULT_OPTS "--color=bg+:$color01,spinner:$color0C,hl:$color0D --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"

set -x FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS -0 -1 --preview='bat -p --color=always --italic-text=always {}'"
set -x FZF_DEFAULT_COMMAND 'fzffind'

set -x EDITOR vim
set -x PAGER most

if status is-interactive
    keychain --eval --quiet -Q id_rsa | source
end

# Clone from here:
# https://github.com/trapd00r/LS_COLORS
eval (dircolors -c ~/Documents/LS_COLORS/LS_COLORS)
