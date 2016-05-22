#!/bin/bash
# Shitload of stuff. Many are specific to Kali Linux v2

# Setting some variables. Might be used later.
update_kali=true

# Updating Kali
if $update_kali 
then
    sudo apt-get update
    sudo apt-get upgrade
fi

# Installing some tools
echo "[wait] Installing some tools"
apt-get install zsh tor shutter keepass2 mingw32 
apt-get install pidgin pidgin-sipe
pip install pyftpdlib
pip install python-nmap
pip install request
pip install pwntools
echo "[done]"

echo "[wait] Installing and configuring oh-my-zsh"
chsh -s /bin/zsh

# Configuring oh-my-zsh
if [ ! -e $HOME/.oh-my-zsh/ ]
then
	sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
fi
sed -i 's/plugins=(\(.*\))/plugins=\(\1 python\)/g' ~/.zshrc
sed -i 's/ZSH_THEME=.*/ZSH_THEME="theunraveler"/g' ~/.zshrc
echo "[done]"

# Adding .vimrc
mv ~/.vimrc ~/.vimrc.bak.`date "+%s"`
ln -s `pwd`/dotfiles/.vimrc ~/.vimrc

# Setting stuff for git
git config --global user.name 'Arnaud Abramovici'
git config --global user.email arnaud@ruuand.fr

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
echo "spool /root/msf_console.log" > /root/.msf5/msfconsole.rc 
grep -q "export PATH=$PATH:/usr/share/metasploit-framework/tools/exploit" $HOME/.env_vars\
    || echo "export PATH=$PATH:/usr/share/metasploit-framework/tools/exploit" >> $HOME/.env_vars
echo "[done]"
