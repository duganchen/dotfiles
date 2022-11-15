# We use my own video thumbnailer. It's much faster than stpv (which also works):
export PATH=$PATH:$HOME/.config/lf/kitty-pistol-previewer

# lf changes directories. This is fairly fundamental to the setup.
lf() {
    # Essentially this:
    # https://github.com/gokcehan/lf/blob/master/etc/lfcd.sh

    tmp="$(mktemp)"
    # Use command to prevent a recursive call. See:
    # https://wiki.vifm.info/index.php/How_to_set_shell_working_directory_after_leaving_Vifm
    command lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

# Stolen. We even keep the command name as "r":
# https://github.com/fdw/ranger-zoxide
# Note that it calls the command above.
r() {
    if [ "$1" != "" ]; then
        if [ -d "$1" ]; then
            lf "$1"
        else
            lf "$(zoxide query $1)"
        fi
    else
        lf
    fi
    return $?
}
