#!/usr/bin/env bash
set -euo pipefail

PLUG=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

INIT_PATH=~/.config/nvim/init.vim
PYTHON3_VENV_PATH=~/.python3-neovim

# Deploy dotfiles.
ln -snf "$(readlink -f vimrc)" ~/.vimrc
mkdir -p ~/.tmp
mkdir -p "$(dirname "$INIT_PATH")"
cat << INIT_VIM > "$INIT_PATH"
let g:python3_host_prog = '$PYTHON3_VENV_PATH/bin/python3'
source ~/.vimrc
INIT_VIM

# Install Plug.
PLUG_PATH="$(readlink -f autoload/plug.vim)"
[[ -e "$PLUG_PATH" ]] || curl -fLo "$PLUG_PATH" --create-dirs "$PLUG"
nvim -u "$INIT_PATH" +PlugInstall +qall

# Tree Sitter set-up.
if command -v tree-sitter >/dev/null 2>&1; then
    nvim -u "$INIT_PATH" +'TSInstall python' +qall
else
    printf 'WARNING: tree-sitter-cli not installed!\n'
fi

# This is a modified Solarized colorscheme for lightline that uses terminal colours.
# TODO: See if the built-in one can be made to work out-of-the-box (potentially with a GitHub PR).
ln -sf ../../../../../solarized_custom.vim plugged/lightline.vim/autoload/lightline/colorscheme/solarized_custom.vim

# Make sure the Python venv exists and has the necessary packages.
if [[ ! -d $PYTHON3_VENV_PATH ]]; then
    python3 -m venv "$PYTHON3_VENV_PATH"
fi
"$PYTHON3_VENV_PATH/bin/pip3" install -U pip pynvim
