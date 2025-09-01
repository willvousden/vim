#!/usr/bin/env bash
set -euo pipefail

PLUG=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

INIT_PATH=~/.config/nvim/init.vim
VIM_PATH=$(pwd)
PLUG_PATH="$VIM_PATH/autoload/plug.vim"
PYTHON3_VENV_PATH=~/.python3-neovim

# Deploy dotfiles.
mkdir -p "$(dirname "$INIT_PATH")"
ln -snf "$VIM_PATH/init.vim" "$INIT_PATH"
ln -snf "$VIM_PATH/vimrc" ~/.vimrc
mkdir -p ~/.tmp

# Install Plug.
[[ -e "$PLUG_PATH" ]] || curl -fLo "$PLUG_PATH" --create-dirs "$PLUG"
nvim -u "$INIT_PATH" +PlugInstall +qall

# This is a modified Solarized colorscheme for lightline that uses terminal colours.
# TODO: See if the built-in one can be made to work out-of-the-box (potentially with a GitHub PR).
ln -sf ../../../../../solarized_custom.vim plugged/lightline.vim/autoload/lightline/colorscheme/solarized_custom.vim

# Make sure the Python venv exists and has the necessary packages.
if [[ ! -d $PYTHON3_VENV_PATH ]]; then
    python3 -m venv "$PYTHON3_VENV_PATH"
fi
"$PYTHON3_VENV_PATH/bin/pip3" install -U pip pynvim
