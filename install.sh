#!/bin/bash
# dotfiles install

cd "$( cd "$( dirname "$0" )" && pwd )"

if [[ $OSTYPE == 'darwin'* ]]; then
  echo 'Installing dotfiles for OSX..'

  # Install oh-my-zsh
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    echo "oh-my-zsh already installed"
  fi

  cp -v .zshrc ~/.zshrc
  cp -v .zshrc_osx ~/.zshrc_osx
  echo 'source $HOME/.zshrc_osx' >> ~/.zshrc

  if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
  fi

  cp -v .vimrc ~/.vimrc
  cp -v .gitattributes ~/.gitattributes
  cp -v .gemrc ~/.gemrc
  cp -v .gitconfig ~/.gitconfig

elif grep -q Ubuntu /etc/issue; then
  echo 'Installing dotfiles for Ubuntu...'

  cp -v .zshrc ~/.zshrc
  cp -v .zshrc_ubuntu ~/.zshrc_ubuntu
  echo 'source $HOME/.zshrc_ubuntu' >> ~/.zshrc

  if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
  fi

  cp -v .vimrc ~/.vimrc
  cp -v .gitattributes ~/.gitattributes
  cp -v .gemrc ~/.gemrc

else
  echo "Don't know how to install for this OS or env."
  exit 1
fi
