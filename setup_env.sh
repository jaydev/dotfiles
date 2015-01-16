#!/usr/bin/env bash

# This script must be run inside the dotfiles
# directory for the symlinks to work.
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

ln -fs $PWD/prelude $HOME/.emacs.d

if [ -d "$HOME/.ipython" ]; then
    ln -fs $PWD/python/ipy_user_conf.py \
        $PWD/python/ipythonrc \
        $HOME/.ipython
fi

if [ ! -x "/usr/local/bin/brew" ]; then
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
fi
brew install ack \
             autojump \
             coreutils \
             curl \
             findutils \
             git \
             node \
             postgresql \
             reattach-to-user-namespace \
             tmux \
             tree \
             wget \
             zsh

brew install emacs --cocoa --srgb
ln -s /usr/local/Cellar/emacs/24.3/Emacs.app /Applications
ln -sf $PWD/prelude/personal/prelude-modules.el $PWD/prelude

cp $PWD/keyremap4macbook/private.xml $HOME/Library/Application \Support/KeyRemap4MacBook

chsh -s /bin/zsh
