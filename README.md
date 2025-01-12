My personal dotfiles.

Start by making sure the appropriate directories exist:

    mkdir -p ~/.config/{bat/themes,micro/colorschemes,kitty,lf/kitty-pistol-previewer,fish/{completions,conf.d,functions,themes},mpv/{fonts,scripts},xplr/plugins,~/.local/share/mc/skins}

And, on Linux:

    mkdir -p ~/.config/environment.d

Install them with GNU stow:

    stow -t ~ cfg

If you're using Linux, also do:

    stow -t ~ linux

And if you're using OS X:

    stow -t ~ osx

And then, on OS X, do some post-install:

    bat cache --build

I use Catppuccin, kitty, fish, starship, mpv, NERD symbols (Jetbrains Mono), lsd and lf, eza (which used to be called exa), etc.

## FISH

Install [fisher](https://github.com/jorgebucaran/fisher), and use it to install the [Catppuccin Mocha](https://github.com/catppuccin/fish) theme and the [tide](https://github.com/IlanCosman/tide) shell.

Run the init_fish.fish script.

## Git and SSH

The options for these aren't really stowable. But here are my notes to copy-and-paste.

For my credential helper, I use libsecret on Linux and keychain on OS X.

The rest of the git config is the standard boilerplate to integrate vscode and
[delta](https://github.com/dandavison/delta).

Here's what I have in ~/.gitconfig for both platforms:

    [core]
    editor = code --wait
    pager = delta
    [diff]
    tool = vscode
    colorMoved = default
    [difftool "vscode"]
    cmd = code --wait --diff $LOCAL $REMOTE
    [merge]
    tool = vscode
    conflictstyle = diff3
    [mergetool "vscode"]
    cmd = code --wait $MERGED
    [interactive]
    diffFilter = delta --color-only
    [delta]
    navigate = true # use n and N to move between diff sections
    light = false

### Mac

In *~/.ssh/config*:

    Host *
        UseKeychain yes
        AddKeysToAgent yes

In *~/.gitconfig*:

    [credential]
    helper = osxkeychain

### Linux

    # On Fedora, install git-credential-libsecret
    [credential]
    helper = libsecret

## VSCode

Some of the extensions I use that are actually worth noting down are:

* [Path Autocomplete](https://marketplace.visualstudio.com/items?itemName=ionutvmi.path-autocomplete) with mappings set for "/", "~" and "$HOME"
* [fish-ide](https://marketplace.visualstudio.com/items?itemName=lunaryorn.fish-ide)
* [fish-vscode](https://marketplace.visualstudio.com/items?itemName=skyapps.fish-vscode)
* [shell-format](https://marketplace.visualstudio.com/items?itemName=foxundermoon.shell-format)
* [ShellCheck](https://marketplace.visualstudio.com/items?itemName=timonwong.shellcheck)

The two shell extensions are from [Microsoft's recommendations](https://microsoft.github.io/code-with-engineering-playbook/code-reviews/recipes/bash/).

## "Plugin Manager" Explanation

There are a lot of "plugin managers" that just clone stuff from git. Here's my system, which uses [git-subrepo](https://github.com/ingydotnet/git-subrepo) and [Stow](https://www.gnu.org/software/stow/).

Let's say I want to use zsh-autosuggestions.

I would do the following:

    git subrepo clone git@github.com:zsh-users/zsh-autosuggestions.git subrepos/zsh-autosuggestions
    mkdir -p cfg/.zsh
    cd cfg/.zsh
    ln -s ../../subrepos/zsh-autosuggestions

The next time I stow the cfg directory, the symbolic link to the zsh-autosuggestions repo gets installed to ~/.zsh/zsh-autosuggestions, where I want it.

## HDR Notes

On my setup (AMD GPU, OLED TV), I only need the following to get games working with HDR:

    DXVK_HDR=1 # Actually what's needed
    PROTON_ENABLE_AMD_AGS=1 # Experimenting with this

I set them in Steam on a game-by-game basis:

    DXVK_HDR=1 PROTON_ENABLE_AMD_AGS=1 gamemoderun %command%