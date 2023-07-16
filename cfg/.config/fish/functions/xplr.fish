function xplr
    set --local pane_id (wezterm cli split-pane --right --percent 33 -- cat /tmp/nnn.fifo)
    wezterm cli activate-pane
    cd (command xplr --print-pwd-as-result $argv)

    # Looks like there's no need to kill the pane or the process in it.
end
