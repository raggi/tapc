runs () {
	run sh -c "$@"
}

tapc() {
	runs "echo \"${1}\" | ./bin/tapc"
}

flunk() {
	{
		if [ "$#" -eq 0 ]; then
			cat -
		else
			echo "$@"
		fi
	} # TODO sed out test dir once helpers are good
	return 1
}

assert_equal() {
	if [ "$1" != "$2" ]; then
		{ echo "expected: $1"
			echo "actual:   $2"
		} | flunk
	fi
}

assert_line() {
	if [ "$1" -ge 0 ] 2>/dev/null; then
		assert_equal "$2" "${lines[$1]}"
	else
		local line
		for line in "${lines[@]}"; do
			if [ "$line" = "$1" ]; then return 0; fi
		done
		# TODO: can't remember how to get lines to join with \n here
		flunk "expected line \`$1' got \`$(printf "%s\n" "${lines[@]}")'"
	fi
}

assert_eline() {
	assert_line "$(echo -e "${*}")"
}
