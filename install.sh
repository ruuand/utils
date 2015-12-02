#!/bin/bash

target_dir=/usr/local/bin

files=`ls`
for file in $files
do
    if [ $file != "install.sh" ];
    then
        if [[ ! -e $target_dir/$file ]]
        then
            ln -s `pwd`/$file $target_dir/$file
        fi
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
