function ja
if not set -qg __dirjumplist
    set -g __dirjumplist $PWD
else
    if not contains $PWD $__dirjumplist
        set -a -g __dirjumplist $PWD
    end
end
    set -g __dirjumplist_idx (count $__dirjumplist)
end
