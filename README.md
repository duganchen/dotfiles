My personal dotfiles.

Install them with GNU stow:

    stow -t ~ cfg

If you're using Linux, also do:

    stow -t ~ linux

And then do some post-install:

    bat cache --build
    fish_config theme save "Catppuccin Mocha"

I use kitty, fish, starship, catppuccin, mpv, NERD fonts (Jetbrains Mono), lsd and lf.

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

[credential]
	helper = osxkeychain