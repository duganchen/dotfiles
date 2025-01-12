#!/usr/bin/env fish

# With https://github.com/sharkdp/vivid/
set -Ux LS_COLORS (vivid generate catppuccin-mocha)
set -Ux EDITOR micro
set -Ux VISUAL 'code --wait'
#  https://gist.github.com/supermarin/6dca255da372c3f9eb26?permalink_comment_id=4773414#gistcomment-4773414
set -Ux MANPAGER 'less -R --use-color -Dd+r -Du+b'
# This is from here, but with the bg removed to preserve transparency:
# https://github.com/catppuccin/fzf
set -Ux FZF_DEFAULT_OPTS "\
  --color=bg+:#313244,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
set -Ux MICRO_TRUECOLOR 1
set -Ux BAT_THEME "Catppuccin Macchiato"