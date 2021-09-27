#!/bin/bash
# dotfiles install

if [ $SPIN ]; then
  echo 'Installing dotfiles for spin...'

  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  cp ~/dotfiles/.zshrc ~/.zshrc
  cp ~/dotfiles/.zshrc_spin ~/.zshrc_spin

  echo 'source $HOME/.zshrc_spin' >> ~/.zshrc
else
  echo 'Installing dotfiles outside of spin...'

  echo 'source $HOME/.zshrc_osx' >> ~/.zshrc
fi
