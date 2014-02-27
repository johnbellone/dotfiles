#!/usr/bin/env zsh
autoload -U compinit promptinit
compinit
promptinit

[ -f $HOME/.aliases ] && . $HOME/.aliases

PROMPT="%F{229}%n@%m%F{238}:%F{216}%~ %F{238}%# %f"
RPROMPT="%F{65}%*%f"

# Print out useful information about this machine.
echo "uptime $(uptime)"

# Print out some diagnostics on a login shell.
[ `command -v ruby 2>/dev/null` ] && echo "$(ruby --version)"
[ `command -v java 2>/dev/null` ] && echo "$(java -version 2>&1 | head -n2 | tail -n1)"
[ `command -v node 2>/dev/null` ] && echo "nodejs $(node --version) npm $(npm --version)"
[ `command -v go 2>/dev/null` ] && echo "$(go version)"
