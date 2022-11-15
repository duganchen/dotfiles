# Just a port of the zsh version.

set PATH $PATH $HOME/.config/lf/kitty-pistol-previewer

function lf
    set tmp (mktemp)
    command lf -last-dir-path=$tmp $argv
    if test -f $tmp
        set dir (cat $tmp)
        rm -f $tmp
        if test -d $dir
            if test "$dir" != "$pwd"
                cd $dir
            end
        end
    end
end

function r
    if set -q argv[1]
        if test -d $argv[1]
            lf $argv[1]
        else
            lf (zoxide query $argv[1])
        end
    else
        lf
    end
end
