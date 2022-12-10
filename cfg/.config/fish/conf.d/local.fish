if test -d /Applications
    set PATH $PATH /Applications/Visual\ Studio\ Code\ 2.app/Contents/Resources/app/bin
end

# https://github.com/ajeetdsouza/zoxide
zoxide init fish | source

# https://github.com/ajeetdsouza/zoxide/issues/328#issuecomment-1033741233
set -Ux _ZO_FZF_OPTS '--bind=ctrl-z:ignore --exit-0 --height=40% --inline-info --no-sort --reverse --select-1 --preview=\'exa -la {2..}\''

# https://starship.rs/
starship init fish | source

# https://micro-editor.github.io/
set -x EDITOR micro

# https://code.visualstudio.com
set -x VISUAL 'code --wait'

mcfly init fish | source

# https://github.com/catppuccin/bat
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

source ~/.config/lf/lf_env.fish

set -x PATH $PATH ~/.local/bin
