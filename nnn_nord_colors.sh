# shellcheck shell=sh

# An attempt at a Nord colorscheme for nnn, Generated using trial and error,
# using colors from here:
# https://tintin.sourceforge.io/info/256color/

BLK=B2
CHR=B2
DIR=25 # Or 21 for the more common dark blue
EXEC=06
FILE=00
MULTIHARDLINK=06
LINK=06
MISSING=00 # Not sure what this is
ORPHAN=C4
FIFO=06
SOCK=06
OTHER=06

export NNN_FCOLORS="$BLK$CHR$DIR$EXEC$FILE$MULTIHARDLINK$LINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
