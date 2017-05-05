#!/usr/bin/env bash
set -euo pipefail

VUNDLE=https://github.com/willvousden/Vundle.vim.git

# Deploy dotfiles.
ln -snf "$(pwd)/vimrc" ~/.vimrc
mkdir -p ~/.tmp

# Install Vundle.
[[ -e $(pwd)/bundle/Vundle.vim ]] || git clone "$VUNDLE" "$(pwd)/bundle/Vundle.vim"
vim -u "$(pwd)/vimrc" +PluginInstall +qall
