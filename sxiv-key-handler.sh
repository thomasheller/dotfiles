#!/bin/sh
case "$1" in
	c)
		cat | xclip -selection clipboard
		notify-send 'filename(s) copied to clipboard'
		;;
esac
