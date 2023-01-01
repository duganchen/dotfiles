# We don't set paths here. Use "set -U fish_user_paths" as needed.
# These are also set with "set -Ux"
# set -x EDITOR micro
# set -x VISUAL 'code --wait'
# https://github.com/ajeetdsouza/zoxide/issues/328#issuecomment-1033741233
# set -Ux _ZO_FZF_OPTS '--bind=ctrl-z:ignore --exit-0 --height=40% --inline-info --no-sort --reverse --select-1 --preview=\'exa -la {2..}\''
# https://github.com/catppuccin/bat
# set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
# Needed on Fedora
# set -x MANROFFOPT "-c"


# https://github.com/ajeetdsouza/zoxide
zoxide init fish | source

# https://starship.rs/
starship init fish | source

source ~/.config/lf/lf_env.fish
