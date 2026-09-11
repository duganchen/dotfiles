# Let's just steal this from Omarchy
function t --wraps='tmux attach || tmux new -s Work' --description 'alias t=tmux attach || tmux new -s Work'
    tmux attach || tmux new -s Work $argv
end
