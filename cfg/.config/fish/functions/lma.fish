function s
if ! test -f ~/.dirmarks.json
    dirmarks init ~/.dirmarks.json
end
dirmarks listall ~/.dirmarks.json
end
