function j
    # Previous versions would add "$result" before the cd.
    # Just pressing "j" repeatedly will jump you between two directories.
    # For now, I'm going to let jp and jn fill that role, and require
    # the act of adding a bookmark to be explicit.

    if ! test -f ~/.dirmarks.json
        dirmarks init ~/.dirmarks.json
        return
    end

    if count $argv > /dev/null
        if set --local result (command dirmarks list (pwd) ~/.dirmarks.json | command fzf --no-sort --select-1 --exit-0 --query $argv)
            cd $result
        end
    else
        if set --local result (command dirmarks list (pwd) ~/.dirmarks.json | command fzf --no-sort --select-1 --exit-0)
            cd $result
        end
    end
end
