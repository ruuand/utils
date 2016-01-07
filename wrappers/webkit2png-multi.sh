#!/usr/bin/bash
# This scripts takes a filename as input. It then iterates over all lines and
# uses webkit2png to take screenshots of the given websites. All files are
# saved in the current folder.

while read url
do
    filename=$(sed 's/http[s]*\:\/\///g' <<< $url)
    webkit2png $url -o $filename
done < $1
