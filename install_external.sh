#!/bin/bash
# This script installs several tools:

current_dir=$(pwd)
if [ ! -e /opt/httpscreenshot/ ]
then
    echo "[wait] Installing httpscreenshot"
    pip install selenium
    git clone https://github.com/breenmachine/httpscreenshot.git /opt/httpscreenshot
    cd /opt/httpscreenshot
    chmod +x ./install-dependencies.sh && ./install-dependencies.sh
    ln -s /opt/httpscreenshot/httpscreenshot.py /usr/local/bin/httpscreenshot
    ln -s /opt/httpscreenshot/screenshotClustering/cluster.py\
        /usr/local/bin/cluster-screenshot
    echo "[done]"
fi

cd $current_dir
if [ ! -e /opt/Veil/ ]
then
    echo "[wait] Installing Veil-Framework"
    git clone https://github.com/Veil-Framework/Veil.git /opt/Veil
    cd /opt/Veil
    bash Install.sh -c
    echo "[done]"
else
    echo "[wait] Updating Veil-Framework"
    cd /opt/Veil
    bash Install.sh -u
    echo "[done]"
fi

cd $current_dir
if [ ! -e /opt/PowerSploit ]
then
    echo "[wait] Installing Powersploit"
    git clone https://github.com/PowerShellMafia/PowerSploit.git /opt/PowerSploit
    echo "[done]"
fi

cd $current_dir
if [ ! -e /opt/PowerShellEmpire ]
then
    echo "[wait] Installing Powersploit"
    git clone https://github.com/powershellempire/empire /opt/PowerShellEmpire
    cd /opt/PowerShellEmpire/setup
    bash install.sh
    echo "[done]"
fi

cd $current_dir
if [ ! -e /opt/pywerview ]
then
    echo "[wait] Installing pywerview"
    git clone https://github.com/the-useless-one/pywerview.git /opt/pywerview
    apt-get install pandoc
    cd /opt/pywerview/
    python setup.py install
    echo "[done]"
fi

cd $current_dir
if [ ! -e /opt/EyeWitness ]
then
    echo "[wait] Installing EyeWitness" ]
    git clone https://github.com/ChrisTruncer/EyeWitness /opt/EyeWitness
    cd /opt/EyeWitness/setup/
    ./setup.sh
    echo "[done]"
fi
