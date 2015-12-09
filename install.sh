#!/bin/bash
# This script installs several utils:
# - Adds a symbolic from /usr/local/bin to the current repo
# - Adds an alias for each each script
#

target_dir=/usr/local/bin

files=`ls`
for file in $files
do
    if [ $file != "install.sh" ];
    then
        if [[ -e $target_dir/$file ]]
        then
            unlink $target_dir/$file
        fi
        ln -s `pwd`/$file $target_dir/$file
    fi
done

for file in $files
do
    echo "alias `basename $file .sh`=$file" >> $HOME/.aliases
done

temp="$(mktemp)"
sort $HOME/.aliases | uniq > $temp
cat $temp > $HOME/.aliases
rm $temp
