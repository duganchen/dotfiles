function jn
if set -gq __dirjumplist
    if set -gq __dirjumplist_idx
        if test $__dirjumplist_idx -eq (count $__dirjumplist)
            set -g __dirjumplist_idx 1
        else
            set -g __dirjumplist_idx (math $__dirjumplist_idx + 1)
        end
    end
    cd $__dirjumplist[$__dirjumplist_idx]
end
end
