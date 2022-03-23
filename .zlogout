#!/usr/bin/env zsh

for x in "$(cdr -l)"; do
    d="$(echo "$x" | awk '{print $2}')"
    if [ ! -d "$d" ]; then
        cdr -P "$d"
    fi
done
