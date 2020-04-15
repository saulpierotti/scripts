# lauches ranger so that when I close it i moved to the new dir

tmp="$(mktemp)"
ranger --choosedir="$tmp" "$@"
if [ -f "$tmp" ]; then
	dir="$(cat "$tmp")"
	rm -f "$tmp"
	if [ -d "$dir" ] && [ "$dir" != "$(pwd)" ]; then
		cd /
	fi
fi
