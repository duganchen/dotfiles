# Terminal Setup

## Shell

* [FISH](https://fishshell.com/) shell
* [lsd](https://github.com/Peltoche/lsd) ls replacement
* [fzf](https://github.com/junegunn/fzf) (including to add Ctrl+R funtionality to FISH)
* [starship](https://starship.rs/) prompt

**~/.config/fish/functions/ls.fish**

`function ls --wraps=lsd --description 'alias ls lsd'`
  `lsd  $argv;`
`end`

**~/.config/fish/config.fish**

`starship init fish | source`
`fzf_key_bindings`

## Terminal

* "Caskaydia Cove" [Nerd Font](https://www.nerdfonts.com/)

### Linux

* [kitty](https://sw.kovidgoyal.net/kitty/) terminal
* [nord-kitty](https://raw.githubusercontent.com/connorholyday/nord-kitty/master/nord.conf) terminal theme

* [nord-xresources](https://github.com/arcticicestudio/nord-xresources) Xresources
* [nord-dircolors](https://github.com/arcticicestudio/nord-dircolors) dircolors