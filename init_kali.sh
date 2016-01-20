#!/bin/bash
# Shitload of stuff. Many are specific to Kali Linux v2

# Setting some variables. Might be used later.
update_kali=false

# Updating Kali
if $update_kali 
then
    sudo apt-get update
    sudo apt-get upgrade
fi

# Installing somt tools
echo "[wait] Installing some tools"
sudo apt-get install zsh tor shutter keepass2
sudo pip install cheat
echo "[done]"

# Configuring oh-my-zsh
if [ ! -e $HOME/.oh-my-zsh/ ]
then
	sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
fi

grep -q "source ~/.aliases" ~/.zshrc || \
    echo "source $HOME/.aliases" >> $HOME/.zshrc
sed -i 's/plugins=(\(.*\))/plugins=\(\1 python\)/g' ~/.zshrc
sed -i 's/ZSH_THEME=.*/ZSH_THEME="theunraveler"/g' ~/.zshrc
chsh -s /bin/zsh

# Adding .vimrc
mv ~/.vimrc ~/.vimrc.bak.`date "+%s"`
ln -s `pwd`/dotfiles/.vimrc ~/.vimrc

# Setting stuff for git
git config --global user.name 'Arnaud Abramovici'
git config --global user.email arnaud@ruuand.fr

# Setting stuff for gdb
grep -q 'set dis intel' ~/.gdbinit || echo "set dis intel"  > ~/.gdbinit

# Settings some aliases
echo "[wait] Setting aliases..."
aliases=('tmp="cd /tmp"'\ 
    'getip="curl http://ipecho.net/plain; echo;"')
echo "[done]"

for a in "${aliases[@]}"
do
    grep -q "$a" $HOME/.aliases || echo "alias $a" >> $HOME/.aliases
done

# Various dotfiles
touch ~/.pentest_env

# Setting locale
grep -q "setxkbmap fr" $HOME/.zshrc || echo "setxkbmap fr" >> $HOME/.zshrc

# Source aliases
grep -q "source ~/.aliases" $HOME/.zshrc || echo "source ~/.aliases" >> $HOME/.zshrc

# Setting stuff specific to Kali 2 Linux
if [[ `uname -a` == *'kali2'* ]]
then
    # Source pentest_env
    grep -q "source ~/.pentest_env" $HOME/.zshrc || echo "source ~/.pentest_env" >> $HOME/.zshrc

    # Adding impacket examples to executables
    echo "[wait] Adding Impacket examples to /usr/local/bin"
    sudo chmod +x /usr/share/doc/python-impacket/examples/*
    for executable in `ls /usr/share/doc/python-impacket/examples/`
    do
        if [[ ! -L /usr/local/bin/$executable ]]
        then
        sudo ln -s /usr/share/doc/python-impacket/examples/$executable\
            /usr/local/bin/$executable
        fi
    done
    echo "[done]"

    # Start postresql at startup (for msf db)
    echo "[wait] Setting some services at startup"
    sudo rcconf --on postgresql
    echo "[done]"

    # Configuring Metasploit
    echo "[wait] Configuring metasploit"
    msfdb init
    echo "[done]"
fi
