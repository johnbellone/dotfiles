#!/usr/bin/env zsh
typeset -U path
path=(bin ~/bin /usr/local/bin /usr/bin /usr/local/sbin /usr/sbin $path)

autoload -U compinit promptinit
compinit
promptinit

PROMPT="%~ %# "
RPROMPT="%u@%m:%*"
