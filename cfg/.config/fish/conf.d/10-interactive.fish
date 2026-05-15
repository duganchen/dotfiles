# This file has stuff I know I'll always want. More host-specific stuff goes elsewhere.
if status is-interactive
    if command -v vivid >/dev/null
        set -x LS_COLORS (vivid generate catppuccin-macchiato)
    end

    if command -v starship >/dev/null
        starship init fish | source
    end

    if command -v fzf >/dev/null
        fzf --fish | source
    end

    # Use bat for man pages
    set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
    set -x MANROFFOPT -c

    if command -v nvim >/dev/null
        set -x EDITOR nvim
    end

    if command -v code >/dev/null
        set -x VISUAL 'code --wait'
    end

    set -x BAT_THEME 'Catppuccin Macchiato'

    # Install fnm and fish_add_path ~/.local/share/fnm
    if command -v fnm
        fnm env --use-on-cd --shell fish | source
    end

    fastfetch
end
