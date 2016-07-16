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

    git clone https://github.com/saliola/dotvim.git ~/.vim

Create symlinks (for vim version < 7.4)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc

Launch vim and install plugins
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    :PlugInstall

------------------------------------------
Working with plugins/bundles as submodules
------------------------------------------

The plugin manager is junegunn's Minimalist Vim Plugin Manager `vim-plug
<https://github.com/junegunn/vim-plug>`__.

