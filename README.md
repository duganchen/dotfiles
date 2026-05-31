# My personal dotfiles.

Start by making sure the appropriate directories exist:

    mkdir -p
    ~/.config/{bat/themes,environment.d,eza,yazi,helix/themes,micro/colorschemes,kitty,fish/{completions,conf.d,functions,themes},mpv/{fonts,scripts,script-opts},nvim/lua/{config,plugins},xplr/plugins,nvim,ghostty,tmux}
    mkdir -p ~/.local/{bin,share/mc/skins} mkdir -p ~/.vim/pack/vendor/start
    mkdir -p ~/.zsh

Install them with GNU stow:

    stow -t ~ cfg

I use a GNOME desktop on Fedora. The terminal is a Catppuccin Macchiato Ghostty
(which has OOTB support for NERD symbols) with fish, starship, mpv, yazi, fnm,
etc.

## FISH

    fish_config theme save catppuccin-macchiato --color-theme dark

## Git and SSH

The options for these aren't really stowable. But here are my notes to
copy-and-paste.

For my credential helper, I use libsecret on Linux (and keychain when I used OS X).

The rest of the git config is the standard boilerplate to integrate meld as the difftool
and mergetool.

Here's what I have in ~/.gitconfig for both platforms:

    [diff]
        tool = meld
    [difftool]
        prompt = false
    [difftool "meld"]
        cmd = meld "$LOCAL" "$REMOTE"

    # On Fedora, install git-credential-libsecret

    [credential]
    helper = libsecret

## "Plugin Manager" Explanation

There are a lot of "plugin managers" that just clone stuff from git. Here's my
system, which uses git submodules and
[Stow](https://www.gnu.org/software/stow/).

Let's say I want to use zsh-autosuggestions.

I would do the following:

    git submodule add git@github.com:zsh-users/zsh-autosuggestions.git
    subrepos/zsh-autosuggestions mkdir -p cfg/.zsh cd cfg/.zsh ln -s
    ../../subrepos/zsh-autosuggestions

The next time I stow the cfg directory, the symbolic link to the
zsh-autosuggestions repo gets installed to ~/.zsh/zsh-autosuggestions, where
I want it.

## Links (for reference)

### CachyOS

- https://github.com/CachyOS/cachyos-fish-config
- https://github.com/CachyOS/cachyos-zsh-config

### Garuda

- https://gitlab.com/moiseslodeiro/garuda-zsh-config
- https://gitlab.com/garuda-linux/pkgbuilds/-/tree/main/garuda-fish-config?ref_type=heads

### Ultramarine

- https://github.com/Ultramarine-Linux/packages/tree/um42/ultramarine/shell-config

### Shell Tooling Setup

- [BASH Code Reviews](https://microsoft.github.io/code-with-engineering-playbook/code-reviews/recipes/bash/)
