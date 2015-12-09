#!/bin/bash
# Shitload of stuff. Many are specific to Kali Linux v2

# Installing zsh, customize .zshrc
sudo apt-get install zsh
sudo apt-get install zsh tor
chsh -s /bin/zsh

# Configuring oh-my-zsh
if [ ! -e $HOME/.oh-my-zsh/ ]
then
	sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
	echo "source $HOME/.aliases" >> $HOME/.zshrc
    sed -i 's/plugins=(\(.*\))/plugins \(\1 python\)/g' .zshrc
fi

# Settings some aliases
echo 'alias tmp="cd /tmp"' >> $HOME/.aliases

# Setting locale
echo "setxkbmap fr" >> $HOME/.zshrc

# Source
echo "source ~/.alias" >> $HOME/.zshrc
echo "source ~/.pentest_env" >> $HOME/.zshrc

# Adding impacket examples to executables
chmod +x /usr/share/doc/python-impacket/examples/*
ln -s /usr/share/doc/python-impacket/examples/ /usr/local/bin/python-impacket/

# Updating
apt-get update
apt-get upgrade