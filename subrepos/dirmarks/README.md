# dirmark

This is (to be) a directory bookmarker. I wrote (am writing) it to integrate into xplr.

Usage:

    dirmark add <directory> /path/to/bookmarks.json

    # Pipe this output into FZF
    dirmark list <current_directory> /path/to/dirmarks.yaml

What sets this apart from all the zillions of existing directory bookmarkers? "dirmark list" filters current_directory out of the list, and "dirmark add", moves the directory to the top of the list if it's already bookmarked. This
allows you to very quickly jump back and forth between two directories, and thus get what you actually
want from a Miller Columns user experience without actually needing one.