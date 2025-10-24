if status is-interactive
    # Commands to run in interactive sessions can go here

    fzf --fish | source
    zoxide init fish | source

    if test -f ~/apps/git-subrepo/.fish.rc
        source ~/apps/git-subrepo/.fish.rc
    end

    fish_add_path ~/.local/bin

    set -x BAT_THEME 'Catppuccin Macchiato'
    set -x MANROFFOPT "-c"
    set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

    fastfetch

    starship init fish | source
end
