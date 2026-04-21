function j
set d (printf %s\n $__dirjumplist | fzf)
if test -d $d
    cd $d
end
end
