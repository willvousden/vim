default: dotfiles

all: dotfiles clone_vundle

.PHONY: default all dotfiles clone_vundle

dotfiles:
	ln -snf `pwd`/vimrc ${HOME}/.vimrc
	ln -snf `pwd` ${HOME}/.vim

clone_vundle:
	git clone git@github.com:gmarik/Vundle.vim.git `pwd`/bundle/Vundle.vim
