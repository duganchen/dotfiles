function j
    _jgc
    if test -f ~/.fish_dir_jumplist.txt
        set -l jumplist (cat ~/.fish_dir_jumplist.txt)
        if set -l index (contains -i $PWD $jumplist)
            set -e jumplist[$index]
        end
        if test (count $jumplist) -gt 0
            if set -q $argv[1]
                set -l d (printf "%s\n" $jumplist | fzf --scheme=path --select-1 --query=$argv[1])
            else
                set -l d (printf "%s\n" $jumplist | fzf --scheme=path --select-1)
                if test -d $d
                    cd $d
                end
            end
        end
    end
end
