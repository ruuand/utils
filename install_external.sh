#!/bin/bash
# This script installs several tools:

# Install discover scripts
if [ ! -e /opt/discover/ ]
then
    git clone https://github.com/leebaird/discover.git /opt/discover
    cd /opt/discover && ./update.sh
fi

if [ ! -e /opt/httpscreenshot/ ]
then
    pip install selenium
    git clone https://github.com/breenmachine/httpscreenshot.git /opt/httpscreenshot
    cd /opt/httpscreenshot
    chmod +x ./install-dependencies.sh && ./install-dependencies.sh
    ln -s /opt/httpscreenshot/httpscreenshot.py /usr/local/bin/httpscreenshot
    ln -s /opt/httpscreenshot/screenshotClustering/cluster.py\
        /usr/local/bin/cluster-screenshot
fi
