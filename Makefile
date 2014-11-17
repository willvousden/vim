default: all

SHELL := /bin/bash
VUNDLE = git@github.com:willvousden/Vundle.vim.git

all: dotfiles install_vundle

dotfiles:
	ln -snf `pwd`/vimrc ${HOME}/.vimrc
	ln -snf `pwd` ${HOME}/.vim

update_vundle: install_vundle
	cd `pwd`/bundle/Vundle.vim && git pull;
	vim -u `pwd`/vimrc +PluginUpdate +qall

install_vundle: 
	[ -e `pwd`/bundle/Vundle.vim ] || git clone $(VUNDLE) `pwd`/bundle/Vundle.vim
	vim -u `pwd`/vimrc +PluginInstall +qall

.PHONY: default all dotfiles install_vundle update_vundle
