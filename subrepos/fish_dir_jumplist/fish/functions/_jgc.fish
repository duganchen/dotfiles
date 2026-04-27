#!/usr/bin/env fish

# Garbage-collect the list.

function _jgc
    if test -f ~/.fish_dir_jumplist.txt
        set -l jumplist (cat ~/.fish_dir_jumplist.txt)
        for i in (seq (count $jumplist) -1 1)
            if not test -d $jumplist[$i]
                set -e jumplist[$i]
            end
        end
        printf "%s\n" $jumplist >~/.fish_dir_jumplist.txt
    end
end
