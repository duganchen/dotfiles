function jp
    _jgc

    if test -f ~/.dir_jumplist.txt
        set -l jumplist (cat ~/.dir_jumplist.txt)
        set -l index (contains --index $PWD $jumplist)
        if test $status -eq 0
            if test $index -eq 1
                cd $jumplist[(count $jumplist)]
            else
                cd $jumplist[(math $index - 1)]
            end
        else
            cd $jumplist[(count $jumplist)]
        end
    end
end
