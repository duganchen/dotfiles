#!/usr/bin/env bash

TEMP=$(mktemp -d)
maim -i "$(xdotool getactivewindow)" "$TEMP/snip.png"
gimp "$TEMP/snip.png"
rm -r "$TEMP"
