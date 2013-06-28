# -*- mode: sh -*-
# ~/.bashrc: executed by bash(1) for non-login shells.

# Alias definitions.
[ -f $HOME/.bash_aliases ] && source $HOME/.bash_aliases

# As the last step execute any local machine specific settings that
# would need to be available on non-interactive logins.
[ -f $HOME/.bash_login ] && source $HOME/.bash_login

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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

export EDITOR="emacs"
export PAGER="less"
export LESS="-R -M"

export PATH
