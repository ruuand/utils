#!/bin/bash
# This script installs several utils:
# - Adds a symbolic from /usr/local/bin to the current repo
# - Adds an alias for each each script
#

target_dir=/usr/local/bin

files="tools/nessus_merger.py tools/parse_nessus_xml.pl tools/iptables-monitor.sh\
    tools/ftpserver.py"

# Installs some prerequisites for parse_nessus_xml.pl
cpan install XML::TreePP Data::Dumper Math::Round Excel::Writer::XLSX\
    Data::Table Excel::Writer::XLSX::Chart

# Adds each file to /usr/local/bin and creates an alias (pentest is the alias
# for pentest.sh, iprange the alias for iprange.py, etc.
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
