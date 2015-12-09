#!/bin/bash
# This scripts makes small modifications to the behaviour of mfsconsole
# - Starts postgresql before launching console

service postgresql start
msfconsle $@
