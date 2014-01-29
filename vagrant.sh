#!/bin/bash

echo "* Installing fish shell"
cd /tmp
sudo aptitude install bc
wget http://fishshell.com/files/2.1.0/linux/Ubuntu/fish_2.1.0-1~precise_amd64.deb
sudo dpkg -i http://fishshell.com/files/2.1.0/linux/Ubuntu/fish_2.1.0-1~precise_amd64.deb

echo "* Cloning dotfiles"
cd /tmp
git clone https://github.com/kmcphillips/dotfiles.git
cd dotfiles

echo "* Copying in config files"
cd dotfiles
cp fish/config.fish /home/vagrant/.config/fish/
mkdir /home/vagrant/.config/fish/functions
cp fish/functions/* /home/vagrant/.config/fish/functions/
