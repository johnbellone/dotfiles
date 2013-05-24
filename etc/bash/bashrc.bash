# -*- mode: sh -*-
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000000
HISTFILESIZE=2000000

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

PS1="\r\n\[\e[0;34m\] \T \[\e[1;34m\]\H\[\e[0;37m\]:\[\e[1;35m\]\W \[\e[1;30m\]$ \[\e[0m\]"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f ~/.bash_localrc ] && source ~/.bash_localrc

[ -d $HOME/homebrew/bin ] && PATH="$HOME/homebrew/bin:$PATH"
[ -d $HOME/bin ] && PATH="$HOME/bin:$PATH"
[ -d $HOME/.rbenv ] && eval "$(rbenv init -)"
[ -z "$RBENV_VERSION" ] && rbenv shell $RBENV_VERSION 

export PATH
