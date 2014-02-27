#!/usr/bin/env zsh
autoload -U compinit promptinit
compinit
promptinit

PROMPT="%F{229}%n@%m%F{238}:%F{216}%~ %F{238}%# %f"
RPROMPT="%F{65}%*%f"
