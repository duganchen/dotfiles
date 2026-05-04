function ja
    _jgc

    if test -f ~/.dir_jumplist.txt
        set -l jumplist (cat ~/.dir_jumplist.txt)
        if not contains $PWD $jumplist
            set -a jumplist $PWD
        end
        printf "%s\n" $jumplist >~/.dir_jumplist.txt
    else
        echo $PWD >~/.dir_jumplist.txt
    end
end
