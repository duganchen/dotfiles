function j
    if count $argv > /dev/null
        if set --local result (command cat ~/.sdirs | command fzf --select-1 --exit-0 --query $argv)
            cd (echo "echo $result" | sh)
        end
    else
        if set --local result (command cat ~/.sdirs | command fzf --select-1 --exit-0)
            cd (echo "echo $result" | sh)
        end
    end
end
