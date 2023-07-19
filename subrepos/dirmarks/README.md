# dirmark

This is a directory bookmarker. I wrote it to integrate into xplr.

Usage:

    dirmarks add <directory> /path/to/bookmarks.json

    # Pipe this output into FZF
    dirmarks list <current_directory> /path/to/bookmarks.json

What sets this apart from all the zillions of existing directory bookmarkers? "dirmark list" filters current_directory out of the list, and "dirmark add", moves the directory to the top of the list if it's already bookmarked. This
allows you to very quickly jump back and forth between two directories, and thus get what you actually
want from a Miller Columns user experience without actually needing one.

The following FISH setup gets you Bashmark-like "s" and "j" commands:

```
function s
    dirmarks add (pwd) ~/.dirmarks.json
end

function j
    if count $argv > /dev/null
        if set --local result (command dirmarks list (pwd) ~/.dirmarks.json | command fzf --no-sort --select-1 --exit-0 --query $argv)
            dirmarks add $result ~/.dirmarks.json
            cd $result
        end
    else
        if set --local result (command dirmarks list (pwd) ~/.dirmarks.json | command fzf --no-sort --select-1 --exit-0)
            dirmarks add $result ~/.dirmarks.json
            cd $result
        end
    end
end
```
