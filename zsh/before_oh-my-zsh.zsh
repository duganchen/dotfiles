# Source this right before the line that sources oh-my-zsh, when the plugin array has "git"
# as its only entry.

# Custom plugin links:
# https://github.com/TamCore/autoupdate-oh-my-zsh-plugins
# https://github.com/zsh-users/zsh-completions
# https://github.com/zsh-users/zsh-autosuggestions
# https://github.com/zdharma/fast-syntax-highlighting

if [ -f /etc/os-release ]; then
    if [[ "$(egrep ^ID /etc/os-release | cut -d= -f2)" == "fedora" ]]; then
        export MANPAGER=most
    else
        # This plugin isn't working for me on Fedora.
        plugins+=(colored-man-pages)
    fi
fi
plugins+=(autoupdate fzf zsh-completions zsh-autosuggestions fast-syntax-highlighting fzf-tab)