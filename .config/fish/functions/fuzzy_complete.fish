function fuzzy_complete
    complete -C | sort -u | fzf --height 40% --multi --reverse -q (commandline -t) | cut --output-delimiter ' ' -f1 | sed s/-//g | clia
    commandline -f end-of-line
end
