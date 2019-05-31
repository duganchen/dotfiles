#!/usr/bin/env bash

TEMP=$(mktemp -d)
maim -s "$TEMP/snip.png"
gimp "$TEMP/snip.png"
rm -r "$TEMP"
