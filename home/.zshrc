#!/usr/bin/env zsh
autoload -U compinit promptinit
compinit
promptinit

[ -f $HOME/.aliases ] && . $HOME/.aliases

# Because Apple decides to ship without the GNU coreutils.
if $(gls &>/dev/null); then
   alias ls="gls -F --color=auto"
fi

PROMPT="%F{229}%n@%m%F{238}:%F{216}%~ %F{238}%# %f"
RPROMPT="%F{65}%*%f"
