set PATH $PATH ~/.local/bin

if test -d /Applications
    set PATH $PATH /Applications/Visual\ Studio\ Code\ 2.app/Contents/Resources/app/bin
end

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
    source /usr/local/opt/fzf/shell/key-bindings.fish
end

fzf_key_bindings

# FZF completion from this project: the rest of it is in the function definitons.
# https://github.com/DevAtDawn/fish-fzf-tab/blob/main/fzf_tab.fish
bind -M insert \et fuzzy_complete

# https://github.com/gokcehan/lf
# https://github.com/duganchen/lf_config
source ~/.config/lf/lf_env.fish
