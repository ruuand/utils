#!/bin/bash
# This script installs several utils:
# - Adds a symbolic from /usr/local/bin to the current repo

target_dir=/usr/local/bin

files="tools/nessus_merger.py tools/parse_nessus_xml.pl tools/ftpserver.py \
	tools/script.sh tools/webkit2png-multi.sh"

# Installs some prerequisites for parse_nessus_xml.pl
cpan install XML::TreePP Data::Dumper Math::Round Excel::Writer::XLSX\
    Data::Table Excel::Writer::XLSX::Chart

# Adds each file to /usr/local/bin
for path in $files
do
    file=`basename $path`
    echo $target_dir/$file
    if [[ -L $target_dir/$file ]]
    then
        unlink $target_dir/$file
    fi
    ln -s `pwd`/$path $target_dir/$file
done
