#!/usr/bin/env bash

# This script must be run inside the dotfiles
# directory for the symlinks to work.
ln -fs $PWD/.dir_colors \
    $PWD/.tmux.conf \
    $PWD/git/.gitignore \
    $PWD/git/.gitconfig \
    $PWD/zsh/.zprofile \
    $PWD/zsh/.zshrc \
    $HOME

ln -fs $PWD/prelude $HOME/.emacs.d
ln -fs $PWD/tmuxp $HOME/.tmuxp

if [ -d "$HOME/.ipython" ]; then
    ln -fs $PWD/python/ipy_user_conf.py \
        $PWD/python/ipythonrc \
        $HOME/.ipython
fi

chsh -s /bin/zsh
