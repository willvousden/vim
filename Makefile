default: dotfiles

all: dotfiles install_vundle

dotfiles:
	ln -snf `pwd`/vimrc ${HOME}/.vimrc
	ln -snf `pwd` ${HOME}/.vim

clone_vundle:
	[ -e `pwd`/bundle/Vundle.vim ] || git clone git@github.com:gmarik/Vundle.vim.git `pwd`/bundle/Vundle.vim

install_vundle: clone_vundle
	vim -u `pwd`/vimrc +PluginInstall +qall

.PHONY: default all dotfiles clone_vundle install_vundle
