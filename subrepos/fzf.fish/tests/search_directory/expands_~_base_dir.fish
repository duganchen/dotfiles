set --export fd_captured_opts
function fd
    set fd_captured_opts $argv
end
mock fzf \* ""
# escape tilde so it doesn't get expanded when echoed
mock commandline --current-token "echo \~/"
mock commandline "--current-token --replace" ""
mock commandline \* ""
_fzf_search_directory
set expected_arg "--base-directory=$HOME"
@test "~/ is expanded to HOME" -n (string match --entire -- $expected_arg $fd_captured_opts)
