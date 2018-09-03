# Currently using Fisherman with the following two plugins:

# https://github.com/rkbk60/onedark-fish
# https://github.com/rafaelrinaldi/pure

set pure_color_blue (set_color "61afef")
set pure_color_cyan (set_color "56b6c2")
set pure_color_gray (set_color "abb2bf")
set pure_color_green (set_color "98c379")
set pure_color_normal (set_color "abb2bf") # Why is this black in the examples?
set pure_color_red (set_color "e06c75")
set pure_color_yellow (set_color "e5c07b")

set -x EDITOR vim
set -x PAGER most

if status is-interactive
    set_onedark -b
    keychain --eval --quiet -Q id_rsa | source
end
