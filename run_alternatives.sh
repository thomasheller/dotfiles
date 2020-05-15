#!/bin/sh

for i in "$@"
do
	if command -v "$i"
	then
		exec "$i"
	fi
done

