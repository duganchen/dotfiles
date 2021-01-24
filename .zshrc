# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd beep extendedglob nomatch notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/dugan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk


if [[ $(uname) == "Linux" ]]; then
	# Fedora 32

	export MANROFFOPT="-c"

	# That's where I have the nnn prefix
	export PATH="$PATH:$HOME/.npm-global/bin"

	# That's where Fedora puts it
	source /usr/share/fzf/shell/key-bindings.zsh
fi

if [[ $(uname) == "Darwin" ]]; then
    alias ls='gls --color=auto --classify'
	source ~/.fzf.zsh
	source ~/.nvm/nvm.sh
	export PATH=~/.local/bin:$PATH:$PATH:/Applications/Visual\ Studio\ Code\ 2.app/Contents/Resources/app/bin:/usr/local/Cellar/llvm/11.0.0_1/bin
    export PATH=$PATH:~/Software/nvim-osx64/bin
fi

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light romkatv/powerlevel10k
zinit snippet https://github.com/sainnhe/sonokai/raw/master/zsh/.zsh-theme-sonokai-atlantis

