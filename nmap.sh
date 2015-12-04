#!/bin/bash
# This scripts makes small modifications to the behaviour of nmap.
# The following changes are made:
# - If the user does not ask for an output (-oN/-oX/-oS/-oG/-oA) he is 
#   prompted for it. The output file has the following format 
#   nmap_`date +%s`.ext
# - If NMAP_FOLDER is set then the output file is placed in the corresponding
#   folder. Otherwise it is placed in the current directory.

output_args="-oN -oX -oS -oG -oA"
output_set=false
default_filename=nmap_`date +%s`
default_folder=./

if [ -z "$NMAP_FOLDER" ] 
then
    folder=$default_folder
else
    folder=$NMAP_FOLDER
fi

for arg in $@
do
    if [[ $output_args == *$arg* ]]
    then
        output_set=true
        break
    fi
done

if [ $output_set = false ]
then
    while true; do
        read -p 'What log format do you want to user ? N (Normal) / X (XML) / G (Greppable) / A (All) / C (Cancel) ' format
        case $format in
            [Nn]* ) output="-oN $folder/$default_filename.nmap"; break;;
            [Xx]* ) output="-oX $folder/$default_filename.xml"; break;;
            [Gg]* ) output="-oG $folder/$default_filename.gnmap"; break;;
            [Aa]* ) output="-oA $folder/$default_filename"; break;;
            [Cc]* ) output=""; break;;
        esac
    done
fi

command nmap $output $@
