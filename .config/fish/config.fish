set -x EDITOR vim

# Well, Slackware.
if test (uname) = Linux
    set -x PATH ~/.local/bin $PATH
    set -x MANPAGER most
end

if test (uname) = Darwin
    ~/.vim/pack/minpac/start/gruvbox/gruvbox_256palette.sh
end


set -x FZF_DEFAULT_COMMAND 'sh -c "git ls-files 2> /dev/null || fd --type f"'
set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

set -x FZF_DEFAULT_OPTS "-0 -1"

set -x FZF_CTRL_T_OPTS "--preview='bat -p --color=always --italic-text=always {}'"

set -x FZF_ALT_C_COMMAND 'fd --type d'

if status --is-interactive
    keychain --eval --quiet -Q id_rsa | source
end


# Using Powerline with both Slackware and OS X. Slackware uses Solarized and
# OS X uses Gruvbox. 

if test (uname) = Linux
    # Agnoster theme
    agnoster powerline
end

if test (uname) = Darwin
    # bobthefish theme
    set -g theme_powerline_fonts yes
    set -g theme_nerd_fonts yes
    set -g theme_color_scheme gruvbox
end

if set -q DISPLAY
    if not set -q TMUX
        tmux attach >/dev/null 2>&1
        or exec tmux
    end
end

# For st on Slackware.

# https://github.com/fish-shell/fish-shell/issues/3425#issuecomment-251714285
if string match -q "st-*" "$TERM"
    set -e VTE_VERSION
end


# Slackware does not add ~/.local/bin to the PATH by default.
if not contains ~/.local/bin $PATH
    set PATH $PATH ~/.local/bin
end
