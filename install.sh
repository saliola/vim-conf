#!/bin/bash

# Clone repo::

git clone https://github.com/saliola/dotvim.git ~/.vim

# Create symlinks (for vim version < 7.4)::

ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc

# Launch vim and run :PlugInstall
