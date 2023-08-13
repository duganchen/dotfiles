function jp
    if ! test -f ~/.dirmarks.json
        dirmarks init ~/.dirmarks.json
        return
    end
    cd (dirmarks previous (pwd) ~/.dirmarks.json)
end
