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

    # https://github.com/catppuccin/fzf
    set -x FZF_DEFAULT_OPTS "\
--color=bg+:#363A4F,spinner:#F4DBD6,hl:#ED8796 \
--color=fg:#CAD3F5,header:#ED8796,info:#C6A0F6,pointer:#F4DBD6 \
--color=marker:#B7BDF8,fg+:#CAD3F5,prompt:#C6A0F6,hl+:#ED8796 \
--color=selected-bg:#494D64 \
--color=border:#6E738D,label:#CAD3F5"
    fastfetch
end
