if [ -f /etc/os-release ]; then
    if [[ "$(egrep ^ID /etc/os-release | cut -d= -f2)" == "fedora" ]]; then
        export MANPAGER=most
    else
        # This isn't working for me on Fedora.
        plugins+=(colored-man-pages)
    fi
fi
plugins+=(autoupdate fzf zsh-completions zsh-autosuggestions fzf-tab zsh-syntax-highlighting)