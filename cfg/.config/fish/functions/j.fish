function j
    if count $argv > /dev/null
        if set --local result (command dirmarks list (pwd) ~/.dirmarks.json | command fzf --no-sort --select-1 --exit-0 --query $argv)
            dirmarks add $result ~/.dirmarks.json
            cd $result
        end
    else
        if set --local result (command dirmarks list (pwd) ~/.dirmarks.json | command fzf --no-sort --select-1 --exit-0)
            dirmarks add $result ~/.dirmarks.json
            cd $result
        end
    end
end
