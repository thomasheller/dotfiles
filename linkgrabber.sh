#!/bin/sh
urls=$(grep -Eo 'https?://[^[:space:]"'\'']+' | tac)
[ -z "$urls" ] && exit
url=$(echo "$urls" | dmenu -p 'Open:')
[ -n "$url" ] && $BROWSER "$url"
