function xplr
    set --local tmp (mktemp -d)
    set -x NNN_FIFO "$tmp/nnn.fifo"
    mkfifo $NNN_FIFO

    command wezterm cli split-pane --right --percent 50 -- ~/.config/xplr/preview $NNN_FIFO $tmp/current_node.fifo

    command wezterm cli activate-pane

    set --local dir (command xplr --print-pwd-as-result $argv)
    if test -n "$dir"
        cd $dir
    end

    if test -d $tmp
        rm -rf $tmp
    end
end
