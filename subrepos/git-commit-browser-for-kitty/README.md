# Git commit browser for Kitty

![demo](usage.gif)

This is a system for using [kitty](https://sw.kovidgoyal.net/kitty/) to browse
git commits, gitk style.

Put git-hash-hints.py in ~/.config/kitty

Put git_show_diff in your PATH.

Put the following in kitty.conf:

    map ctrl+shift+p>h kitten hints --program @ --type regex --regex "\b([0-9a-f]{6}|[0-9a-f]{7}|[0-9a-f]{8}|[0-9a-f]{40})\b"
    map ctrl+shift+p>g kitten hints --program "launch --cwd=current git_show_diff" --type regex --regex "\b([0-9a-f]{6}|[0-9a-f]{7}|[0-9a-f]{8}|[0-9a-f]{40})\b"

Display the git log in the terminal:

![log](screenshots/log.png)

Press Ctrl+Shift+b and then g. You'll see a number next to each commit on the screen:

![hints](screenshots/hints.png)

Enter one of the numbers to see that commit:

![hints](screenshots/preview.png)

Press "q" to close the preview window.

Or press Ctrl+Shift+b and then h. Choose a hash, and it will be copied to the clipboard.

As of now, it's at the "works on my computer" (OS X, with Delta as the git pager) stage.
