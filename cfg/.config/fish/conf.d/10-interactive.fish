if status is-interactive
    # Commands to run in interactive sessions can go here

    fzf --fish | source
    zoxide init fish | source

    if test -f ~/.local/src/git-subrepo/.fish.rc
        source ~/.local/src/git-subrepo/.fish.rc
    end

    fish_add_path ~/.local/bin

    set -x BAT_THEME 'Catppuccin Macchiato'
    set -x MANROFFOPT "-c"
    set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
    set -v VISUAL 'code --wait'

    # https://github.com/catppuccin/fzf/blob/main/themes/catppuccin-fzf-macchiato.fish
    set -x FZF_DEFAULT_OPTS "\
--color=bg+:#363A4F,spinner:#F4DBD6,hl:#ED8796 \
--color=fg:#CAD3F5,header:#ED8796,info:#C6A0F6,pointer:#F4DBD6 \
--color=marker:#B7BDF8,fg+:#CAD3F5,prompt:#C6A0F6,hl+:#ED8796 \
--color=selected-bg:#494D64 \
--color=border:#6E738D,label:#CAD3F5"

    fastfetch

    starship init fish | source
end
