#!/usr/bin/env python
# 

from netaddr import *
import sys

def get_cidrs(ip_start, ip_end):
    return ', '.join([str(range) for range in netaddr.iprange_to_cidrs(ip_start, ip_end)])

if __name__ == '__main__':
    if len(sys.argv) == 3:
        print(get_cidrs(sys.argv[1], sys.argv[2]))
    else:
        print('Expecting start ip and end ip')
