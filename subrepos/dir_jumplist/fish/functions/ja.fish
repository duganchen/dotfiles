function ja
    _jgc

    if test -f ~/.fish_dir_jumplist.txt
        set -l jumplist (cat ~/.fish_dir_jumplist.txt)
        if not contains $PWD $jumplist
            set -a jumplist $PWD
        end
        printf "%s\n" $jumplist >~/.fish_dir_jumplist.txt
    else
        echo $PWD >~/.fish_dir_jumplist.txt
    end
end
