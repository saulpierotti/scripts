# lauches ranger so that when I close it i moved to the new dir
# in order to make cd work I need to source it, not run

tmp="$(sudo mktemp)"
sudo ranger --choosedir="$tmp" "$@"
if [ -f "$tmp" ]; then
	dir="$(sudo cat "$tmp")"
	sudo rm -f "$tmp"
	[ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
fi
