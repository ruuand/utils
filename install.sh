#!/bin/bash
# This script installs several utils:
# - Adds a symbolic from /usr/local/bin to the current repo
# - Adds an alias for each each script
#

target_dir=/usr/local/bin

files="wrappers/nmap.sh wrappers/script.sh iprange.py pentest.sh"
for path in $files
do
    file=`basename $path`
    echo $target_dir/$file
    if [[ -L $target_dir/$file ]]
    then
        unlink $target_dir/$file
    fi
    ln -s `pwd`/$path $target_dir/$file
    no_ext=`echo $file | cut -d'.' -f1`
    grep -q "alias $no_ext=$file" $HOME/.aliases || \
        echo "alias $no_ext=$file" >> $HOME/.aliases
done
