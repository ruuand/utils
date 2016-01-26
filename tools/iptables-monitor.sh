#!/bin/bash
# This scripts uses iptables to monitor the amount of traffic sent to a specific
# host.

echo $#
if [ "$#" -ne 1 ]; then
    echo $'Usage:\niptables-monitor XXX.XXX.XXX.XXX'
    exit 1
fi

iptables -I INPUT -1 -s $target -j ACCEPT
iptables -I OUTPUT -1 -d $target -j ACCEPT
iptables -Z
