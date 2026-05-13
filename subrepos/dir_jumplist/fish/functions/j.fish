function j
    _jgc
    if test -f ~/.dir_jumplist.txt
        set -l jumplist (cat ~/.dir_jumplist.txt)
        if set -l index (contains --index $PWD $jumplist)
            set -e jumplist[$index]
        end
        if test (count $jumplist) -gt 0
            set -f d
            if count $argv >/dev/null
                set -f d (printf "%s\n" $jumplist | fzf --scheme=path --exact --select-1 --query=$argv[1])
            else
                set -f d (printf "%s\n" $jumplist | fzf --scheme=path --exact --select-1)
            end

            if test -n "$d" && test -d $d
                cd $d
            end
        end
    end
end
