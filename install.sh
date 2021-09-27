#!/bin/bash
# spin install

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cp ~/dotfiles/.zshrc ~/.zshrc
cp ~/dotfiles/.zshrc_spin ~/.zshrc_spin

echo 'source $HOME/.zshrc_spin' >> ~/.zshrc
