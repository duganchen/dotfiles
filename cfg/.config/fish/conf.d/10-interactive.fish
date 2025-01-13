if status is-interactive
    # Commands to run in interactive sessions can go here

    fzf --fish | source
    zoxide init fish | source

    abbr --add la eza --icons --all --group-directories-first
    abbr --add l eza --icons --group-directories-first
    abbr --add lla eza --icons --all --long --group-directories-first
    abbr --add ll eza --icons --long --group-directories-first

    if test -f ~/apps/git-subrepo/.fish.rc
        source ~/apps/git-subrepo/.fish.rc
    end

    fish_add_path ~/.local/bin
end
