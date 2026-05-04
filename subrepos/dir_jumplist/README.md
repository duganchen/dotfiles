# Directory Jumplist

A directory changer. The original intent was to be like the Helix jumplist, but
the main inspiration ended up being the Harpoon plugin for neovim; it treats
directories like Harpoon treats buffers. You add directories to a jumplist, and
then jump back and forth.

The functions are:

- _ja_ adds the current directory to the jumplist.
- _jn_ goes to the next directory in the jumplist.
- _jp_ goes to the previous directory to the jumplist.
- _j \[foo\]_ gives you an [fzf](https://junegunn.github.io/fzf/) picker for the
  directory to jump to. Specifying foo will query for directories in the
  jumplist that match foo.

The jumplist is stored in ~/.dir_jumplist.txt and you can edit or delete that
file as needed.

## Workflow Notes

The only thing I supplement this with (other than FISH's very powerful
completion for the cd command) is [broot](https://dystroy.org/broot/), using the
following as an additional directory changer:

    br --only-folders

### Why I Wrote This

I'm not a fan of frecency-based directory changers (fasd) because they're not
predictable.

I don't really like directory changers that hook into the cd command (zoxide,
autojump, etc), because presenting me with my entire cd history gives me too
much noise to sort through.

I find directory-bookmarkers (bashmarks) too cumbersome and limited.

I tried to get into the directory stacks provided by most shells. Couldn't do
it.

All of these have things I like. I want to explicitly add directories to the
jumplist so that it contains only what I want. I want a menu to choose from
directories in the jumplist. I want to easily go back and forth between
directories in the jumplist. And I want to be able to easily edit the jumplist
(this project just makes it easy to edit it with a text editor).

## Contributor's Guide

I have fish-lsp and bash-language-server set to format-on-save. Please set up
your editor or IDE similarly.
