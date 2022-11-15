My personal dotfiles.

Install them with GNU stow:

    stow -t ~ cfg

And then do some post-install:

    bat cache --build
    fish_config theme save "Catppuccin Mocha"