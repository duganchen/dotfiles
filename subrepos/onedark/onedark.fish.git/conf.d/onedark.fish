# OneDark color palette.
set -l mono_1 abb2bf
set -l mono_2 828997
set -l mono_3 5c6370
set -l mono_4 4b5263

set -l hue_1 56b6c2 # cyan
set -l hue_2 61afef # blue
set -l hue_2_2 4f97d7 # blue
set -l hue_3 c678dd # purple
set -l hue_3_2 7590db # blue
set -l hue_4 98c379 # green

set -l hue_5 e06c75 # red 1
set -l hue_5_2 be5046 # red 2

set -l hue_6 d19a66 # orange 1
set -l hue_6_2 e5c07b # orange 2

set -l syntax_bg 282c34
set -l syntax_gutter 636d83
set -l syntax_cursor 2c323c
set -l syntax_accent 528bff

set -l vertsplit 181a1f
set -l special_grey 3b4048
set -l visual_grey 3e4452
set -l pmenu 333841

# Syntax highlighting colors.
set -g fish_color_normal $mono_1
set -g fish_color_command $hue_2
set -g fish_color_keyword $hue_3
set -g fish_color_quote $hue_6_2
set -g fish_color_redirection $mono_1
set -g fish_color_end $hue_6
set -g fish_color_error $hue_5
set -g fish_color_param $mono_1
set -g fish_color_comment $mono_2
set -g fish_color_selection --background=$pmenu
set -g fish_color_search_match --background=$pmenu
set -g fish_color_operator $hue_4
set -g fish_color_escape $hue_3
set -g fish_color_autosuggestion $mono_2

# Completion pager colors.
set -g fish_pager_color_progress $mono_2
set -g fish_pager_color_prefix $hue_1
set -g fish_pager_color_completion $mono_1
set -g fish_pager_color_description $mono_2
