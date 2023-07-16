function xplr
    set --local pane_id (command wezterm cli split-pane --right --percent 33 -- ~/.config/xplr/preview)
    command wezterm cli activate-pane

    set --local dir (command xplr --print-pwd-as-result $argv)
    if test -n "$dir"
        cd $dir
    end
end
