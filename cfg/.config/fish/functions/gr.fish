function gr
    # This is from Google AI, but Google AI seems to have gotten it
    # from here:
    # https://www.reddit.com/r/fishshell/comments/6ofhob/looking_for_quick_shortcut_to_get_to_git_root/
    set -l root (git rev-parse --show-toplevel 2>/dev/null)
    if test $status -eq 0
        cd $root
    else
        echo "Not a git repository"
    end
end
