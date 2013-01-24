# This file is run only on the initial login (when a terminal tab is opened)
# but not when screen is invoked or a new screen frame is created.
# Basically, if it says "Last login: ..." then this file is run.

#=============
# SYSTEM PATHS
#=============
# These paths will be typeset automatically.

fpath=(
  /usr/local/Cellar/zsh/4.3.11/share/zsh/site-functions \
  /usr/local/Cellar/zsh/4.3.11/share/zsh/functions \
)

path=(
  /usr/local/bin \
  /usr/local/git/bin \
  /usr/local/python/bin \
  /usr/local/share/python \
  /usr/local/sbin \
  /usr/texbin \
  /usr/bin \
  /usr/java/bin \
  /usr/X11R6/bin \
  /usr/local/lib/node_modules/.bin \
  $HOME/.rvm/bin \
  $HOME/.gem/ruby/1.8/bin \
  $path \
  . \
)

manpath=(
  /usr/local/share/man \
  /usr/share/man \
  /usr/local/git/share/man
  /Library/TeX/Distributions/.DefaultTeX/Contents/Man \
  /usr/X11/man \
)

# Set INFOPATH for emacs info file reading
infopath=(
  $HOME/info \
  /usr/share/info \
  /usr/lib/info \
)

# Remove duplicate entries from paths
typeset -U fpath path manpath infopath

#=============
# CUSTOM PATHS
#=============
# These paths need to be typeset manually.
# See `man zshbuiltins` for more options.

## Python
export PYTHONPATH=$HOME:\
$HOME/src
# Python virtual environments
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/share/python/virtualenvwrapper.sh

# Node.js
export NODE_PATH=/usr/local/lib/node_modules

#============
# OTHER STUFF
# ===========

export TERM=xterm-256color  # Support for 256 colors
export MANPAGER='less -R -S'  # Useful for manpages that contain ASCII markup
export VERSIONER_PYTHON_PREFER_32_BIT=yes
# This is used by git when doing "git commit -a" without the -m.
# See ChangeLog within emacs.
export EDITOR='emacs'
export NODE_ENV=development

#============
# SSH
# ===========

if [ -x /usr/bin/ssh-add ]; then
  ssh-add $HOME/.ssh/id_dsa > /dev/null 2>&1
fi

#============
# RUBY
# ===========

# Load RVM into a shell session *as a function*
# This must come last
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
