function xplr
    set --local pane_id (wezterm cli split-pane --right --percent 33 -- ~/.config/xplr/preview)
    wezterm cli activate-pane
    set --local dir (command xplr --print-pwd-as-result $argv)
    if test -n "$dir"
        cd $dir
    end

    # Looks like there's no need to kill the pane or the process in it.
end
