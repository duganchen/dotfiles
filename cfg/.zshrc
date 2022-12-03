# I was going to use https://github.com/mattmc3/zshrc.d
# but ended up not bothering

source ~/.zsh/lscolors.sh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [[ -f /usr/share/fzf/shell/key-bindings.zsh ]]; then
source /usr/share/fzf/shell/key-bindings.zsh
fi