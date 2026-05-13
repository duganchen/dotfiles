# Requires BASH 4.2+

_jgc() {
	# Garbage collect the list

	local -a jumplist=()
	if [ -f ~/.dir_jumplist.txt ]; then
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

ja() {
	_jgc

	if [ -f ~/.dir_jumplist.txt ]; then
		local -a jumplist=()
		mapfile -t jumplist <~/.dir_jumplist.txt
		local found=0
		for dir in "${jumplist[@]}"; do
			if [[ "$dir" == "$PWD" ]]; then
				found=1
				break
			fi
		done

		if [[ $found -eq 0 ]]; then
			jumplist+=("$PWD")
		fi
		printf "%s\n" "${jumplist[@]}" >~/.dir_jumplist.txt
	else
		echo "$PWD" >>~/.dir_jumplist.txt
	fi
}

jn() {
	_jgc

	if [ -f ~/.dir_jumplist.txt ]; then
		local -a jumplist=()
		mapfile -t jumplist <~/.dir_jumplist.txt

		local found=0
		for i in "${!jumplist[@]}"; do
			if [[ "$PWD" == "${jumplist[$i]}" ]]; then
				found=1
				break
			fi
		done

		if [ $found -eq 1 ]; then
			if [ "$i" -eq "$((${#jumplist[@]} - 1))" ]; then
				cd "${jumplist[0]}" || return
			else

				i=$((i + 1))
				cd "${jumplist[$i]}" || return
			fi
		else
			cd "${jumplist[0]}" || return
		fi
	fi
}

jp() {
	_jgc

	if [ -f ~/.dir_jumplist.txt ]; then
		local -a jumplist=()
		mapfile -t jumplist <~/.dir_jumplist.txt

		local found=0
		for i in "${!jumplist[@]}"; do
			if [[ "$PWD" == "${jumplist[$i]}" ]]; then
				found=1
				break
			fi
		done

		if [ $found -eq 1 ]; then
			if [ "$i" -eq 0 ]; then
				cd "${jumplist[-1]}" || return
			else
				i=$((i - 1))
				cd "${jumplist[$i]}" || return
			fi
		else
			cd "${jumplist[-1]}" || return
		fi
	fi
}

j() {
	_jgc

	if [ -f ~/.dir_jumplist.txt ]; then

		local -a jumplist=()
		mapfile -t jumplist <~/.dir_jumplist.txt

		local found=0
		local i=0

		for i in "${!jumplist[@]}"; do
			if [[ "$PWD" == "{jumplist[$i]}" ]]; then
				unset "${jumplist[$i]}"
				jumplist=("${jumplist[@]}")
				break
			fi
		done

		if [ ${#jumplist[@]} -gt 0 ]; then
			local d
			if [[ "$1" != "" ]]; then
				d=$(printf "%s\n" "${jumplist[@]}" | fzf --scheme=path --select-1 --query="$1")
			else
				d=$(printf "%s\n" "${jumplist[@]}" | fzf --scheme=path --select-1 --query="$1")
			fi
			cd "$d" || return
		fi
	fi
}
