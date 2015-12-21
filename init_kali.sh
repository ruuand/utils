#!/bin/bash
# Shitload of stuff. Many are specific to Kali Linux v2

# Setting some variables. Might be used later.
dropbox=true

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
ln -s `pwd`/dotfiles/.zshrc ~/.zshrc

# Setting stuff for git
git config --global user.name 'Arnaud Abramovici'
git config --global user.email arnaud@ruuand.fr

# Settings some aliases
grep -q "alias tmp" $HOME/.aliases || echo 'alias tmp="cd /tmp"' >> $HOME/.aliases

# Setting locale
grep -q "setxkbmap fr" $HOME/.zshrc || echo "setxkbmap fr" >> $HOME/.zshrc

# Source aliases
grep -q "source ~/.alias" $HOME/.zshrc || echo "source ~/.alias" >> $HOME/.zshrc

# Setting stuff specific to Kali 2 Linux
if [[ `uname -a` == *'kali2'* ]]
then
    # Source pentest_env
    grep -q "source ~/.pentest_env" $HOME/.zshrc || echo "source ~/.pentest_env" >> $HOME/.zshrc

    # Adding impacket examples to executables
    sudo chmod +x /usr/share/doc/python-impacket/examples/*
    sudo ln -s /usr/share/doc/python-impacket/examples/ /usr/local/bin/python-impacket/

    # Start postresql at startup (for msf db)
    sudo rcconf --on postgresql
fi

if [[ $dropbox ]]
then
    cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
    wget https://www.dropbox.com/download\?dl\=packages/dropbox.py\
        -O /usr/local/bin/dropbox.py
    echo "# Dropbox CLI\nalias dropbox=dropbox.py" >> $HOME/.aliases
fi

