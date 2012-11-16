# This file is run whenever a new terminal is opened (e.g., new screen tab).
# It should contain things that must be rerun every time a shell is opened.

#============
# COMPLETION
#============
# added by new user install
zstyle :compinstall filename '/Users/jaydevm/.zshrc'
autoload -Uz compinit
compinit

# Git file completion in zsh is *really* slow. This is a fix to change it so
# filenames will complete like they do normally.
__git_files(){ _main_complete _files }

# case-insensitive, partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# complete jobs/processes for the `kill` command
zstyle ':completion:*:*:kill:*' verbose yes
# cache results
zstyle ':completion:*' use-cache on
# ignore completion functions for commands you don’t have
zstyle ':completion:*:functions' ignored-patterns '_*'

# allow extended globbing, e.g. opposite ^*.txt, OR (foo|bar)*.txt, recursive **/*.txt
setopt extended_glob
# Don't require a leading dot for matching hidden files
setopt glob_dots

# quick change dirs (type ... and it turns into ../..)
rationalise-dot() {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+=/..
  else
    LBUFFER+=.
  fi
}
zle -N rationalise-dot
bindkey . rationalise-dot

#====================
# COMMAND LINE (ZLE)
#====================
# use emacs keybindings at prompt
bindkey -e
# no beeping at invalid commands
unsetopt BEEP
# remap M-h from run-help to Emacs backward delete word
bindkey -r '\eh'
bindkey '\eh' backward-delete-word
# Remove period and forward slash from what is considered part of a word.
# Makes editing with forward and backward delete word much easier.
export WORDCHARS='*?_-[]~=&;!#$%^(){}<>'

#====================
# CHANGE DIRECTORIES
#====================
# type the name of a directory to cd to it (if it's not a valid command)
setopt AUTO_CD
# resolve symbolic links when changing directory
setopt CHASE_LINKS

#=========
# HISTORY
#=========
# multiple shells retain the same history (hell YES)
# to access other shell's history, must press enter in already running shell
setopt SHARE_HISTORY
# save timestamps. use history -f to get date and time
setopt EXTENDED_HISTORY
# do not save consecutive repeated commands
setopt HIST_IGNORE_DUPS
# don't return items that were already found when reverse-searching history
setopt HIST_FIND_NO_DUPS
# oldest duplicates expire first
setopt HIST_EXPIRE_DUPS_FIRST
# remove superfluous blanks from history
setopt HIST_REDUCE_BLANKS
# add to history as soon as command is executed, rather than waiting until
# the end of the session to write out to the history file
setopt INC_APPEND_HISTORY
# NOTE: must have SAVEHIST <= HISTSIZE, for unspecified reasons
# http://zsh.sourceforge.net/Guide/zshguide02.html#l7
HISTSIZE=1000000
# number of lines to save in HISTFILE
SAVEHIST=1000000
HISTFILE=~/.zsh_history

#=============
# JOB CONTROL
#=============
# don't send HUP signal to running jobs when shell exits
setopt NOHUP

#========
# PROMPT
#========
# Initialize colors.
autoload -U colors
colors

# Allow for functions in the prompt.
setopt PROMPT_SUBST

## git prompt based off of
## http://kriener.org/articles/2009/06/04/zsh-prompt-magic

# set some colors
for COLOR in RED GREEN YELLOW WHITE BLACK CYAN BLUE MAGENTA; do
    eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'
    eval PR_BRIGHT_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done
PR_RESET="%{${reset_color}%}";

# Need this to get git info
autoload -Uz vcs_info

# Set formats
# %b - branchname
# %a - action (e.g. rebase-i)
# %r - repository name
# for more vcs_info options,
# see http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#SEC273
FMT_REPO="${PR_BRIGHT_BLUE}±${PR_RESET}|${PR_BRIGHT_BLUE}%r${PR_RESET}" # e.g. base
FMT_BRANCH="${PR_BRIGHT_BLUE}%b${PR_RESET}" # e.g. master
FMT_ACTION="${PR_BRIGHT_MAGENTA}%a${PR_RESET}%" # e.g. (rebase-i)

zstyle ':vcs_info:*' enable git # only enable vcs_info for git
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_REPO}|${FMT_BRANCH}|${FMT_ACTION}  "
zstyle ':vcs_info:*:prompt:*' formats "${FMT_REPO}|${FMT_BRANCH} "

function precmd {
    vcs_info 'prompt'
}

# My prompt looks like
# ±|repo|branch|actions hostname:$PWD:
PS1='${vcs_info_msg_0_}'
PS1+="${PR_BRIGHT_RED}%m${PR_RESET}|${PR_BRIGHT_YELLOW}%~${PR_RESET}: " # hostname:$PWD

#===========
# DIRCOLORS
#===========
# make the colors displayed by ls be more visible against a dark background
eval `dircolors ~/.dir_colors`

#==========
# AUTOJUMP
#==========
#autojump
#Copyright Joel Schaerer 2008, 2009
#This file is part of autojump

#autojump is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#autojump is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with autojump.  If not, see <http://www.gnu.org/licenses/>.

#local data_dir=${XDG_DATA_HOME:-$([ -e ~/.local/share ] && echo ~/.local/share || echo ~)}
local data_dir=$([ -e ~/.local/share ] && echo ~/.local/share || echo ~)
if [[ "$data_dir" = "${HOME}" ]]
then
    export AUTOJUMP_DATA_DIR=${data_dir}
else
    export AUTOJUMP_DATA_DIR=${data_dir}/autojump
fi
if [ ! -e "${AUTOJUMP_DATA_DIR}" ]
then
    mkdir "${AUTOJUMP_DATA_DIR}"
    mv ~/.autojump_py "${AUTOJUMP_DATA_DIR}/autojump_py" 2>>/dev/null #migration
    mv ~/.autojump_py.bak "${AUTOJUMP_DATA_DIR}/autojump_py.bak" 2>>/dev/null
    mv ~/.autojump_errors "${AUTOJUMP_DATA_DIR}/autojump_errors" 2>>/dev/null
fi

function autojump_preexec() {
    { (autojump -a "$(pwd -P)"&)>/dev/null 2>>|${AUTOJUMP_DATA_DIR}/autojump_errors ; } 2>/dev/null
}

typeset -ga preexec_functions
preexec_functions+=autojump_preexec

alias jumpstat="autojump --stat"

function j { local new_path="$(autojump $@)";if [ -n "$new_path" ]; then echo -e "\\033[31m${new_path}\\033[0m"; cd "$new_path";fi }

#=========
# ALIASES
#=========

# Unix
alias ackl='ack --pager="less -r"'
alias em='emacs'
alias emacs='emacs -nw'
alias grepc='grep --color=always'
alias -g L='| less'
alias less='less -R'
alias ll='ls -alrth --color'
alias ls='ls -FGa --color'
alias P='ps aux | grep'
alias tm='tmux'
alias tree='tree -C'

# Git
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gca='git commit --amend'
alias gci='git commit -a'
alias gco='git checkout'
alias gd='git diff'
alias gds='git diff --staged'
alias gh='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'
alias gl='git log'
alias glme='git log --author=jaydevm'
alias gm='git merge'
alias gp='git pull'
alias gpr='git pull --rebase'
alias gps='git push'
alias gr='git reset'
alias gs='git status'
alias gsm='git submodule'
alias gst='git stash'
alias gsu='cd $HOME/base && git submodule update && cd -'

# Python
alias cq='codequality'
alias ipy='ipython'
# Alias ipython so it correctly imports python package paths set by a virtualenv
# See http://scipy2010.blogspot.com/2010/06/scipy-2010-basic-tutorials-ipython-and.html
alias ipython='python /usr/local/share/python/ipython'
alias llsp='lssitepackages -alrth --color'
alias mpy='./manage.py'
alias py='python'
alias pyg='pygmentize'
alias python='python -W ignore::DeprecationWarning'

# Rails
alias rc='bundle exec rails console'
alias rs='bundle exec rails server'

# Database
alias mgd='mongod run --config /usr/local/Cellar/mongodb/1.8.2-x86_64/mongod.conf --logpath /usr/local/var/mongodb/mongo.log --fork'
alias pg='pg_ctl -D $HOME/var/postgres/db -l $HOME/var/postgres/log/postgres.log'
alias redis-start='launchctl start io.redis.redis-server'
alias redis-stop='launchctl stop io.redis.redis-server'
