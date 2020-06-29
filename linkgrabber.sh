#!/bin/sh
urls=$(grep -aEo '(https?://[^[:space:]"'\'']+|([a-z0-9-]+\.)+[a-z]+)' | tac)
[ -z "$urls" ] && exit
url=$(echo "$urls" | dmenu -p 'Open:')
[ -n "$url" ] && $BROWSER "$url"
