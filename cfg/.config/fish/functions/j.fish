function j
    # The adds are to make it easy to jump to the last directory you jumped to. I like that.
    # Just pressing "j" repeatedly will jump you between two directories.

    if count $argv > /dev/null
        if set --local result (command dirmarks list (pwd) ~/.dirmarks.json | command fzf --tac --no-sort --select-1 --exit-0 --query $argv)
            dirmarks add $result ~/.dirmarks.json
            cd $result
        end
    else
        if set --local result (command dirmarks list (pwd) ~/.dirmarks.json | command fzf --tac --no-sort --select-1 --exit-0)
            dirmarks add $result ~/.dirmarks.json
            cd $result
        end
    end
end
