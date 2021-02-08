=====================
My .vim configuration
=====================

--------------------------------
Installation in three easy steps
--------------------------------

The included script ``install.sh`` automates the steps below.

Clone repo
~~~~~~~~~~

::

    git clone git@github.com:saliola/vim-conf.git ~/.vim
    cd ~/.vim

Create symlinks (for vim version < 7.4)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc

Launch vim and install plugins
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Install plugins::

    :PlugInstall

Update plugins::

    :PlugUpdate

Upgrade vim-plug::

    :PlugUpgrade

------------------------------------------
Working with plugins/bundles as submodules
------------------------------------------

The plugin manager is junegunn's Minimalist Vim Plugin Manager `vim-plug
<https://github.com/junegunn/vim-plug>`__.

