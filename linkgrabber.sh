#!/bin/sh
url=$(grep -Eo 'https?://[^[:space:]"'\'']+' | tac | dmenu -p 'Open:')
[ -n "$url" ] && $BROWSER "$url"
