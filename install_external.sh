#!/bin/bash
# This script installs several tools:

echo "[wait] Installing httpscreenshot"
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
echo "[done]"
