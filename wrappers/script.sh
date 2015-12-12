#!/bin/bash
# This scripts makes small modifications to the behaviour of the script
# util from util-linux. The following changes are made:
# - The default filename is no longer typescript but is script_`date +%s`.log.
#   If a filename is specified then this filename is used.
# - If SCRIPT_FOLDER is set then the log file is placed in the corresponding
#   folder. Otherwise it is placed in the current directory.

default_filename=script_`date +%s`.log
default_folder=./

if [ -z "$SCRIPT_FOLDER" ] 
then
    folder=$default_folder
else
    folder=$SCRIPT_FOLDER
fi

if [[ $# -eq 0 ]]
then
    command script $folder/$default_filename
else
    command script $1
fi
