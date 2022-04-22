set PATH $PATH ~/.local/bin
zoxide init fish | source
starship init fish | source

export EDITOR='code --wait'
export VISUAL='code --wait'

if test -f /usr/share/fzf/shell/key-bindings.fish
    source /usr/share/fzf/shell/key-bindings.fish
end
fzf_key_bindings
