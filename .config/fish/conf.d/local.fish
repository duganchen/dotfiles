set PATH $PATH ~/.local/bin

if test -d /Applications
    set PATH $PATH /Applications/Visual\ Studio\ Code\ 2.app/Contents/Resources/app/bin
end

# https://github.com/ajeetdsouza/zoxide
zoxide init fish | source

# https://github.com/ajeetdsouza/zoxide/issues/328#issuecomment-1033741233
set -Ux _ZO_FZF_OPTS '--bind=ctrl-z:ignore --exit-0 --height=40% --inline-info --no-sort --reverse --select-1 --preview=\'exa -la {2..}\''

# https://starship.rs/
starship init fish | source

# https://code.visualstudio.com
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

# https://github.com/gokcehan/lf
# https://github.com/duganchen/lf_config
source ~/.config/lf/lf_env.fish

# Yeah I cloned https://github.com/trapd00r/LS_COLORS/ here
source ~/.config/LS_COLORS/lscolors.csh
