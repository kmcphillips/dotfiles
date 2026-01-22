#!/bin/bash
# dotfiles install

set -euo pipefail

cd "$( cd "$( dirname "$0" )" && pwd )"

if [[ $OSTYPE == 'darwin'* ]]; then
  echo -e '\033[1;36mInstalling dotfiles for OSX\033[0m'

  if which brew > /dev/null 2>&1; then
    echo 'Homebrew is already installed'
  else
    echo 'Homebrew is not installed and should be installed first'
    echo -e '\033[1;31mAbort\033[0m'
    exit 1
  fi

  if which starship > /dev/null 2>&1; then
    echo 'Starship is installed.'
  else
    echo 'Starship is not installed. Installing...'
    brew install starship
  fi

  if which atuin > /dev/null 2>&1; then
    echo 'Atuin is installed.'
  else
    echo 'Atuin is not installed. Installing...'
    brew install atuin
  fi

  if brew list --cask font-fira-code-nerd-font > /dev/null 2>&1; then
    echo 'FiraCode Nerd Font is installed.'
  else
    echo 'FiraCode Nerd Font is not installed. Installing...'
    brew install --cask font-fira-code-nerd-font
  fi

  # TODO: I think I can copy in an iterm2 config and a cursor config
  echo -e '\033[1;33mImportant:\033[0m Make sure iTerm2 profile is configured to use \033[1mFiraCode Nerd Font\033[0m.'

  if brew list antidote > /dev/null 2>&1; then
    echo 'Antidote package manager is installed.'
  else
    echo 'Antidote package manager is not installed. Installing...'
    brew install antidote
  fi

  if which mise > /dev/null 2>&1; then
    echo 'Mise is installed.'
  else
    echo 'Mise is not installed. Installing...'
    brew install mise
  fi

  if which rbenv > /dev/null 2>&1; then
    echo 'Rbenv is installed.'
  else
    echo 'Rbenv is not installed. Installing...'
    brew install rbenv
  fi

  cp -v .zshrc ~/.zshrc
  cp -v .zshrc_osx ~/.zshrc_osx
  cp -v .zsh_plugins.txt ~/.zsh_plugins.txt
  echo 'source $HOME/.zshrc_osx' >> ~/.zshrc

  mkdir -p ~/.config
  cp -v .vimrc ~/.vimrc
  cp -v .zprofile ~/.zprofile
  cp -v .gitattributes ~/.gitattributes
  cp -v .gemrc ~/.gemrc
  cp -v .gitconfig ~/.gitconfig
  cp -v starship.toml ~/.config/starship.toml


elif grep -q Ubuntu /etc/issue; then
  echo -e '\033[1;36mInstalling dotfiles for Ubuntu\033[0m'

  cp -v .zshrc ~/.zshrc
  cp -v .zshrc_ubuntu ~/.zshrc_ubuntu
  cp -v .zsh_plugins.txt ~/.zsh_plugins.txt
  echo 'source $HOME/.zshrc_ubuntu' >> ~/.zshrc

  if which starship > /dev/null 2>&1; then
    echo 'Starship is installed.'
  else
    echo 'Starship is not installed. Installing...'
    curl -sS https://starship.rs/install.sh | sh
  fi

  if [ -d "$HOME/.atuin/bin" ]; then
    echo 'Atuin is installed.'
  else
    echo 'Atuin is not installed. Installing...'
    bash <(curl https://raw.githubusercontent.com/atuinsh/atuin/main/install.sh)
  fi

  FONT_DIR="$HOME/.local/share/fonts"
  if [ -f "$FONT_DIR/FiraCodeNerdFont-Regular.ttf" ] || fc-list | grep -q "FiraCode"; then
    echo 'FiraCode Nerd Font is installed.'
  else
    echo 'FiraCode Nerd Font is not installed. Installing...'
    mkdir -p "$FONT_DIR"
    cd /tmp
    curl -L -o FiraCode.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
    unzip -q FiraCode.zip -d "$FONT_DIR"
    rm FiraCode.zip
    fc-cache -fv "$FONT_DIR" > /dev/null 2>&1
    echo 'FiraCode Nerd Font installed successfully.'
  fi

  echo -e '\033[1;33mImportant:\033[0m Make sure terminal is configured to use \033[1mFiraCode Nerd Font\033[0m.'

  ANTIDOTE_DIR="${ZDOTDIR:-$HOME}/.antidote"
  if [ -d "$ANTIDOTE_DIR" ]; then
    echo 'Antidote repository exists. Updating...'
    cd "$ANTIDOTE_DIR"
    git pull
    cd - > /dev/null
  else
    echo 'Antidote repository does not exist. Cloning...'
    git clone --depth=1 https://github.com/mattmc3/antidote.git "$ANTIDOTE_DIR"
  fi

  echo "TODO: Install mise"
  echo "TODO: Install rbenv"

  mkdir -p ~/.config/atuin

  cp -v .vimrc ~/.vimrc
  cp -v .gitattributes ~/.gitattributes
  cp -v .gemrc ~/.gemrc
  cp -v starship.toml ~/.config/starship.toml

else
  echo "Don't know how to install for this OS or env."
  echo -e '\033[1;31mAbort\033[0m'
  exit 1
fi

echo -e '\033[1;32mDone\033[0m'
