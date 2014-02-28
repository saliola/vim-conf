=====================
My .vim configuration
=====================

--------------------------------
Installation in three easy steps
--------------------------------

The included script ``install.sh`` automates the steps below.

Clone repo::

    git clone https://github.com/saliola/dotvim.git ~/.vim

Create symlinks (for vim version < 7.4)::

    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc

Switch to the `~/.vim` directory, and fetch submodules::

    cd ~/.vim
    git submodule init
    git submodule update

----------------------------------
Working with plugins as submodules
----------------------------------

Install a plugin as a submodule::

    cd ~/.vim/
    git submodule add git://github.com/tpope/vim-sensible.git bundle/vim-sensible
    git add .
    git commit -m "Install vim-sensible bundle as a git submodule."

Upgrading a plugin::

    cd ~/.vim/bundle/vim-sensible
    git pull origin master

Upgrading all plugins::

    cd ~/.vim
    git submodule foreach git pull origin master

Pulling changes that include a new plugin::

    git pull origin master
    git submodule init
    git submodule update

----------
References
----------

I set up this repository following this excellent blog post:

- `Synchronizing plugins with git submodules and pathogen <http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/>`__
