#!/bin/bash
# This script installs several tools:

# Installs python-webkit2png
cd python-webkit2png
./setup.py install
cd ..

# Install discover scripts
git clone https://github.com/leebaird/discover.git /opt/discover
cd /opt/discover && ./update.sh
