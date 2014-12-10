default: all

VUNDLE := git@github.com:willvousden/Vundle.vim.git

all: dotfiles install_vundle

dotfiles:
	@ln -snfv `pwd`/vimrc ${HOME}/.vimrc

update_vundle: install_vundle
	cd `pwd`/bundle/Vundle.vim && git pull
	vim -u `pwd`/vimrc +PluginClean +qall
	vim -u `pwd`/vimrc +PluginUpdate +qall

install_vundle:
	[ -e `pwd`/bundle/Vundle.vim ] || git clone $(VUNDLE) `pwd`/bundle/Vundle.vim
	vim -u `pwd`/vimrc +PluginInstall +qall

.PHONY: default all dotfiles install_vundle update_vundle
