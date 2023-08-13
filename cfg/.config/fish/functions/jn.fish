function jn
    if ! test -f ~/.dirmarks.json
        dirmarks init ~/.dirmarks.json
    end
    cd (dirmarks next (pwd) ~/.dirmarks.json)
end
