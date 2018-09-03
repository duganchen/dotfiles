# Currently using Fisherman with the following two plugins:

# https://github.com/rkbk60/onedark-fish
# https://github.com/rafaelrinaldi/pure

set pure_color_blue (set_color "61afef")
set pure_color_cyan (set_color "23878c")
set pure_color_gray (set_color "abb2bf")
set pure_color_green (set_color "699959")
set pure_color_normal (set_color "000000")
set pure_color_red (set_color "be5046")
set pure_color_yellow (set_color "d19a66")

set -x EDITOR vim
set -x PAGER most

if status is-interactive
    set -l onedark_options '-b'

    if set -q VIM
        # Using from vim/neovim.
        set onedark_options "-256"
    else if string match -iq "eterm*" $TERM
        # Using from emacs.
        function fish_title; true; end
        set onedark_options "-256"
    end

    set_onedark $onedark_options

    keychain --eval --quiet -Q id_rsa | source
end
