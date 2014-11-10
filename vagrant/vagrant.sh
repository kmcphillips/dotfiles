#!/bin/bash

HOME_DIR="/home/vagrant"
SRC_DIR="$HOME_DIR/src"

echo ""
echo "Configuring vagrant from kmcphillips/dotfiles"
echo ""


echo ""
echo "**** Cloning dotfiles"
if [ ! -d "$SRC_DIR/dotfiles" ]; then
  cd "$SRC_DIR"
  git clone https://github.com/kmcphillips/dotfiles.git
fi
cd "$SRC_DIR/dotfiles"
git pull


echo ""
echo "**** Checking for bash plugins"

if [ ! -d "~/.bash" ]; then
  mkdir ~/.bash
fi
if [ ! -d "~/.bash/git-aware-prompt" ]; then
  cd ~/.bash
  git clone git://github.com/jimeh/git-aware-prompt.git
fi


echo ""
echo "**** Copying in config files"
cd "$SRC_DIR/dotfiles/vagrant"
FISH_CONFIG_DIR="$HOME_DIR/.config/fish"

if [ ! -d "$FISH_CONFIG_DIR" ]; then
  mkdir --parents $FISH_CONFIG_DIR
fi
if [ ! -d "$FISH_CONFIG_DIR/functions" ]; then
  mkdir $FISH_CONFIG_DIR/functions
fi
cp -v fish/config.fish $FISH_CONFIG_DIR/
cp -v fish/functions/* $FISH_CONFIG_DIR/functions/

cp -v vagrant/.bash_profile ~/.bash_profile

echo ""
echo "**** Copying in bin files"
cd "$SRC_DIR/dotfiles"
if [ ! -d "$HOME_DIR/bin" ]; then
  mkdir $HOME_DIR/bin
fi
cp -v vagrant/bin/* $HOME_DIR/bin/
chmod +x $HOME_DIR/bin/*


echo ""
echo "**** Updating system config files"
grep PrintLastLog /etc/ssh/sshd_config > /dev/null
if [ $? -eq 0 ];
then
  echo "PrintLastLog already exists in /etc/ssh/sshd_config"
else
  echo "Appending to sshd_config:"
  echo "PrintLastLog no" | sudo tee -a /etc/ssh/sshd_config
  sudo service ssh restart
fi


echo ""
echo "Done"
