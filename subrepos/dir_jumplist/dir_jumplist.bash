_jgc() {
	# Garbage collect the list
	# Requires Bash 4

	local -a jumplist=()
	if [[ -f ~/.dir_jumplist.txt ]]; then
		# https://stackoverflow.com/a/30988704
		mapfile -t jumplist <~/.dir_jumplist.txt

		for i in "${!jumplist[@]}"; do
			if [[ ! -d "${jumplist[$i]}" ]]; then
				unset "jumplist[$i]"
			fi
		done
		jumplist=("${jumplist[@]}")

		printf "%s\n" "${jumplist[@]}" >~/.dir_jumplist.txt
	fi
}
