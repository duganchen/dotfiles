function s
if ! test -f ~/.dirmarks.json
    dirmarks init ~/.dirmarks.json
end
dirmarks add (pwd) ~/.dirmarks.json
end
