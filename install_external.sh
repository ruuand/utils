#!/bin/bash
# This script installs several tools:

# Install discover scripts
git clone https://github.com/leebaird/discover.git /opt/discover
cd /opt/discover && ./update.sh
