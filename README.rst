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

Switch to the `~/.vim` directory, and fetch submodules
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    cd ~/.vim
    git submodule init
    git submodule update

------------------------------------------
Working with plugins/bundles as submodules
------------------------------------------

Install a plugin as a submodule
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    cd ~/.vim/
    git submodule add git://github.com/tpope/vim-sensible.git bundle/vim-sensible
    git add .
    git commit -m "Install vim-sensible bundle as a git submodule."

Upgrading a plugin
~~~~~~~~~~~~~~~~~~

::

    cd ~/.vim/bundle/vim-sensible
    git pull origin master

Upgrading all plugins
~~~~~~~~~~~~~~~~~~~~~

::

    cd ~/.vim
    git submodule foreach git pull origin master

Pulling changes that include a new plugin
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    git pull origin master
    git submodule init
    git submodule update

Delete a plugin
~~~~~~~~~~~~~~~

`Delete a plugin`__ requires version > ``git1.8.3``::

    cd ~/.vim
    git submodule deinit bundle/snipmate.vim
    git rm bundle/snipmate.vim # Note: no trailing slash

__ http://stackoverflow.com/questions/1260748/how-do-i-remove-a-git-submodule

Generate helptags
~~~~~~~~~~~~~~~~~

::

    :Helptags

From the VimCast for `Synchronizing plugins with git submodules and pathogen`__:

    ... generating helptags dirties the submodule’s git repository tree.
    Several other people chimed in with suggestions on how to fix this. Nils
    Haldenwang has written a `blog post`__ describing a simple fix, which just
    involves adding the line ``ignore = dirty`` to the ``.gitmodules`` file for
    each submodule that reports a dirty tree when you run git status.

__ http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/
__ http://www.nils-haldenwang.de/frameworks-and-tools/git/how-to-ignore-changes-in-git-submodules


----------
References
----------

I set up this repository following this excellent blog post:

- `Synchronizing plugins with git submodules and pathogen <http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/>`__
