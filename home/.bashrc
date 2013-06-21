# -*- mode: sh -*-
# ~/.bashrc: executed by bash(1) for non-login shells.

# Source JavaScript and Ruby environments.
[ -f ~/.jsrc ] && source ~/.jsrc
[ -f ~/.rbrc ] && source ~/.rbrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# don't put duplicate lines or lines starting with space in the history.
export HISTIGNORE="&:pwd:ls:sl:l:ll:la:lh:h:history"
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignoreboth
export HISTTIMEFORMAT='%F %T '

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

PS1="\r\n\[\e[38;5;208m\] \t \[\e[1;34m\]\H\[\e[0;37m\]:\[\e[1;35m\]\W \[\e[1;30m\]$ \[\e[0m\]"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

export EDITOR="emacs -nw"
export PAGER="less"
export LESS="-R -M"

export PATH

# As the last step execute any local machine specific settings that
# would need to be available on non-interactive logins.
[ -f ~/.bash_login ] && source ~/.bash_login
