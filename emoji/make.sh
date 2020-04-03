#!/bin/bash
# Download emoji list version 13.0 from Unicode
# and convert it into format suitable for dmenu.
set -e
echo Fetching emoji list...
curl -so emoji-test.txt 'https://unicode.org/Public/emoji/13.0/emoji-test.txt'
grep -vE '^(#.*|\s*)$' emoji-test.txt | sed 's/^\([0-9A-F ]\+[0-9A-F]\)\s\+\?;.\+# \(.\+\) E[0-9]\+\.[0-9]\+\(.\+\)/\2\3 ; \1/g' > emoji.txt
echo Done.
