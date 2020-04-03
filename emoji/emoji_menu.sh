#!/bin/bash
unicode=$(dmenu -i -l 30 <$HOME/.config/emoji/emoji.txt | sed 's/.*; //')
[ -z "$unicode" ] && exit
for u in $unicode; do xdotool key U$u; done
