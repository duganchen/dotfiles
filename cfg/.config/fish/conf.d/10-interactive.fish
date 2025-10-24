if status is-interactive
    # Commands to run in interactive sessions can go here

    fzf --fish | source
    zoxide init fish | source

    if test -f ~/apps/git-subrepo/.fish.rc
        source ~/apps/git-subrepo/.fish.rc
    end

    fish_add_path ~/.local/bin
end
