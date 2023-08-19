function d
if ! test -f ~/.dirmarks.json
    dirmarks init ~/.dirmarks.json
end
dirmarks delete (pwd) ~/.dirmarks.json
end
