#!/usr/bin/env bash
set -euo pipefail

PLUG=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

VIM_PATH=$(pwd)
VIMRC_PATH=$VIM_PATH/vimrc
PLUG_PATH="$VIM_PATH/autoload/plug.vim"

# Deploy dotfiles.
ln -snf "$VIMRC_PATH" ~/.vimrc
mkdir -p ~/.tmp

# Install Plug.
[[ -e "$PLUG_PATH" ]] || curl -fLo "$PLUG_PATH" --create-dirs "$PLUG"
vim -u "$VIMRC_PATH" +PlugInstall +qall

if hash nvim 2> /dev/null; then
    echo "Don't forget to set up Python for Neovim!"
    echo '    $ pip install pynvim'
fi
