#!/usr/bin/env zsh
autoload -U compinit promptinit
compinit
promptinit

[ -f $HOME/.aliases ] && . $HOME/.aliases

PROMPT="%F{229}%n@%m%F{238}:%F{216}%~ %F{238}%# %f"
RPROMPT="%F{65}%*%f"
