#!/usr/bin/env zsh
typeset -U path
path=(bin ~/bin /usr/local/opt/coreutils/libexec/gnubin /usr/local/bin /usr/bin /usr/local/sbin /usr/sbin $path)
manpath=(/usr/local/opt/coreutils/libexec/gnuman $path)
