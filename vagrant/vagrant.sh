#!/bin/bash

HOME_DIR="/home/vagrant"
SRC_DIR="$HOME_DIR/src"

echo ""
echo "Configuring vagrant from kmcphillips/dotfiles"
echo ""


if which fish &> /dev/null; then
  echo "**** Fish already installed at:"
  which fish
else
  echo "**** Installing fish shell"
  cd /tmp
  sudo aptitude install bc
  wget http://fishshell.com/files/2.1.0/linux/Ubuntu/fish_2.1.0-1~precise_amd64.deb
  sudo dpkg -i fish_2.1.0-1~precise_amd64.deb
fi


echo ""
echo "**** Cloning dotfiles"
if [ ! -d "$SRC_DIR/dotfiles" ]; then
  cd "$SRC_DIR"
  git clone https://github.com/kmcphillips/dotfiles.git
fi
cd "$SRC_DIR/dotfiles"
git pull


echo ""
echo "**** Copying in config files"
cd "$SRC_DIR/dotfiles"
FISH_CONFIG_DIR="$HOME_DIR/.config/fish"
if [ ! -d "$FISH_CONFIG_DIR/functions" ]; then
  mkdir $FISH_CONFIG_DIR/functions
fi
cp -v fish/config.fish $FISH_CONFIG_DIR/
cp -v fish/functions/* $FISH_CONFIG_DIR/functions/


echo ""
echo "**** Copying in bin files"
cd "$SRC_DIR/dotfiles"
if [ ! -d "$HOME_DIR/bin" ]; then
  mkdir $HOME_DIR/bin
fi
cp -v vagrant/bin/* $HOME_DIR/bin/
chmod +x $HOME_DIR/bin/*

echo ""
echo "Done"
