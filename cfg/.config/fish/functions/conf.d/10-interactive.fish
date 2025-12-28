# This file has stuff I know I'll always want. More host-specific stuff goes elsewhere.
if status is-interactive
	set -x LS_COLORS (vivid generate catppuccin-macchiato)
	starship init fish | source
	zoxide init fish | source
	fzf --fish | source
end
