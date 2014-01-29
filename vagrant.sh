#!/bin/bash

SRC_DIR="/home/vagrant/src"


if which fish &> /dev/null; then
  echo "* Fish already installed at:"
  which fish
else
  echo "* Installing fish shell"
  cd /tmp
  sudo aptitude install bc
  wget http://fishshell.com/files/2.1.0/linux/Ubuntu/fish_2.1.0-1~precise_amd64.deb
  sudo dpkg -i http://fishshell.com/files/2.1.0/linux/Ubuntu/fish_2.1.0-1~precise_amd64.deb
fi


echo "* Cloning dotfiles"
if [ ! -d "$SRC_DIR/dotfiles" ]; then
  cd "$SRC_DIR"
  git clone https://github.com/kmcphillips/dotfiles.git
fi
cd "$SRC_DIR/dotfiles"
git pull


echo "* Copying in config files"
cd "$SRC_DIR/dotfiles"
cp fish/config.fish /home/vagrant/.config/fish/
mkdir /home/vagrant/.config/fish/functions
cp fish/functions/* /home/vagrant/.config/fish/functions/


if grep LINEMAN_AUTO_START ~/.bashrc
then
  echo "* Already in .bashrc"
else
  echo "* Append to .bashrc"
  echo "export LINEMAN_AUTO_START=false" >> ~/.bashrc
fi
