set PATH $PATH ~/.local/bin

# https://github.com/ajeetdsouza/zoxide
zoxide init fish | source

# https://starship.rs/
starship init fish | source

# https://code.visualstudio.co
export EDITOR='code --wait'
export VISUAL='code --wait'

# https://github.com/junegunn/fzf

# Fedora
if test -f /usr/share/fzf/shell/key-bindings.fish
    source /usr/share/fzf/shell/key-bindings.fish
end

# OS X
if test -f /usr/local/opt/fzf/shell/key-bindings.fish
    source /usr/share/fzf/shell/key-bindings.fish
end

fzf_key_bindings

# https://github.com/gokcehan/lf
# https://github.com/duganchen/lf_config
source ~/.config/lf/lf_env.fish

function ls
    # https://github.com/Peltoche/lsd
    lsd $argv
end
