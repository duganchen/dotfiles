function jn
    _jgc

    if test -f ~/.fish_dir_jumplist.txt
        set -l jumplist (cat ~/.fish_dir_jumplist.txt)
        for i in (seq (count $jumplist))
            if test $jumplist[$i] = $PWD
                set found
                break
            end
        end
        if set -q found
            if test $i -eq (count $jumplist)
                cd $jumplist[1]
            else
                cd $jumplist[(math $i + 1)]
            end
        else
            cd $jumplist[1]
        end
    end
end
