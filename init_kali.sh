#!/bin/bash
# Shitload of stuff. Many are specific to Kali Linux v2

# Updating
sudo apt-get update
sudo apt-get upgrade

sudo apt-get install zsh tor shutter
chsh -s /bin/zsh

# Configuring oh-my-zsh
if [ ! -e $HOME/.oh-my-zsh/ ]
then
	sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
	echo "source $HOME/.aliases" >> $HOME/.zshrc
    sed -i 's/plugins=(\(.*\))/plugins \(\1 python\)/g' .zshrc
fi

# Adding .zshrc
mv ~/.zshrc ~/.zshrc.bak.`date "+%s"`
ln -s dotfiles/.zshrc ~/.zshrc

# Setting stuff for git
git config --global user.name 'Arnaud Abramovici'
git config --global user.email arnaud@ruuand.fr

# Settings some aliases
echo 'alias tmp="cd /tmp"' >> $HOME/.aliases

# Setting locale
echo "setxkbmap fr" >> $HOME/.zshrc

# Source aliases
echo "source ~/.alias" >> $HOME/.zshrc

# Setting stuff specific to Kali Linux
if [[ `uname -a` == *'kali'*]]
then
    # Source pentest_env
    echo "source ~/.pentest_env" >> $HOME/.zshrc

    # Adding impacket examples to executables
    sudo chmod +x /usr/share/doc/python-impacket/examples/*
    sudo ln -s /usr/share/doc/python-impacket/examples/ /usr/local/bin/python-impacket/

    # Start postresql at startup (for msf db)
    sudo rcconf --on postgresql
fi
