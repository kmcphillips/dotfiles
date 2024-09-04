#!/bin/bash
# dotfiles install

cd "$( cd "$( dirname "$0" )" && pwd )"

if [ $SPIN ]; then
  echo 'Installing dotfiles for spin...'

  sudo apt install exa -y

  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  cp -v ~/dotfiles/.zshrc ~/.zshrc
  cp -v ~/dotfiles/.zshrc_spin ~/.zshrc_spin
  echo 'source $HOME/.zshrc_spin' >> ~/.zshrc

  if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
  fi

  cp -v .vimrc ~/.vimrc
  cp -v .gitattributes ~/.gitattributes
  cp -v .gemrc ~/.gemrc
  cp -v .zlogin ~/.zlogin
  cat .gitconfig_spin >> ~/.gitconfig

  git config advice.skippedCherryPicks false

  ## This doesn't work because it needs to be done in context of Shopify/shopify ruby version
  # gem install grb pry

  git clone https://github.com/shopify/cursor-dotfiles ~/shopify-dotfiles/cursor-dotfiles
  chmod +x ~/shopify-dotfiles/cursor-dotfiles/install.sh
  ~/shopify-dotfiles/cursor-dotfiles/install.sh

elif [[ $OSTYPE == 'darwin'* ]]; then
  echo 'Installing dotfiles for OSX..'

  cp -v .zshrc ~/.zshrc
  cp -v .zshrc_osx ~/.zshrc_osx
  echo 'source $HOME/.zshrc_osx' >> ~/.zshrc

  if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
  fi

  cp -v .vimrc ~/.vimrc
  cp -v .gitattributes ~/.gitattributes
  cp -v .gemrc ~/.gemrc

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
