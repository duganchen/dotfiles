function jn
    _jgc

    if test -f ~/.dir_jumplist.txt
        set -l jumplist (cat ~/.dir_jumplist.txt)
        set -l index (contains --index $PWD $jumplist)
        if test $status -eq 0
            if test $index -eq (count $jumplist)
                cd $jumplist[1]
            else
                cd $jumplist[(math $index + 1)]
            end
        else
            cd $jumplist[1]
        end
    end
end
