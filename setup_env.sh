#!/usr/bin/env bash
ln -fs $PWD/.ackrc \
    $PWD/.dir_colors \
    $PWD/.tmux.conf \
    $PWD/git/.gitignore \
    $PWD/git/.gitconfig \
    $PWD/bash/.bash_profile \
    $PWD/zsh/.zprofile \
    $PWD/zsh/.zshrc \
    $PWD/.ctags \
    $HOME
ln -fs $PWD/git/pre-commit $HOME/base/.git/hooks
if [ -d "$HOME/.ipython" ]; then
    ln -fs $PWD/ipy_user_conf.py \
        $PWD/ipythonrc \
        $HOME/.ipython
fi
