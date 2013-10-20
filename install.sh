#!/bin/bash

# Clone repo::

git clone https://github.com/saliola/dotvim.git ~/.vim

# Create symlinks (for vim version < 7.4)::

ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc

# Switch to the `~/.vim` directory, and fetch submodules::

cd ~/.vim
git submodule init
git submodule update
