# FISH Directory Jumplist

A FISH directory changer. The original intent was to be like the Helix jumplist, but
the main inspiration ended up being the Harpoon plugin for neovim;
it treats directories like Harpoon treats buffers.  
You add directories to a jumplist, and then jump back and forth.

The functions are:

* *ja* adds the current directory to the jumplist.
* *jn* goes to the next directory in the jumplist.
* *jp* goes to the previous directory to the jumplist.
* *j \[foo\]* gives you an [fzf](https://junegunn.github.io/fzf/) picker for the directory to jump to.
Specifying foo will query for directories in the jumplist that match foo.

The jumplist is stored in ~/.fish_dir_jumplist.txt and you can edit or delete
that file as needed.

## Workflow Notes

The only thing I supplement this with (other than FISH's very powerful completion for the cd command)
is [broot](https://dystroy.org/broot/), using the following as an additional directory changer:

    br --only-folders
