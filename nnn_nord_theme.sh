# shellcheck shell=sh

# Tested in iterm using the script here:
# https://askubuntu.com/a/821163

BLK="0B"
CHR="0B"
DIR="04"
EXEC="06"
FILE="00"
MULTIHARDLINK="06"
LINK="06"
MISSING=00 # Not sure what this is
ORPHAN="09"
FIFO="06"
SOCK="0B"
OTHER=06

export NNN_FCOLORS="$BLK$CHR$DIR$EXEC$FILE$MULTIHARDLINK$LINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
