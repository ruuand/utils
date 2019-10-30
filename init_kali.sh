#!/bin/bash
# Shitload of stuff. Many are specific to Kali Linux v2

# Setting some variables. Might be used later.

SCRIPT_DIR=realpath ${0}

# Installing some tools
echo "[wait] Installing some tools"
apt install zsh keepass2
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
ln -s $SCRIPT_DIR/dotfiles/vimrc ~/.vimrc

mv ~/.zshrc ~/.zshrc.bak.`date "+%s"`
ln -s $SCRIPT_DIR/dotfiles/zshrc ~/.zshrc

ln -s $SCRIPT_DIR/dotfiles/aliases ~/.aliases

# Setting stuff for git
git config --global user.name 'ruuand'
git config --global user.email arnaud@ruuand.fr

# Configuring Metasploit
echo "[wait] Configuring metasploit"
msfdb init
echo "spool /root/msf_console.log" > /root/.msf4/msfconsole.rc 
grep -q "export PATH=$PATH:/usr/share/metasploit-framework/tools/exploit" $HOME/.env_vars\
    || echo "export PATH=$PATH:/usr/share/metasploit-framework/tools/exploit" >> $HOME/.env_vars
echo "[done]"
