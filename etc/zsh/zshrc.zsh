DOT=$HOME/dotfiles
ZSH=$HOME/.zsh

source $DOT/etc/env.sh
source $ZSH/git-prompt/zshrc.sh

autoload -U promptinit && promptinit
PROMPT='%F{24}%* %E%F{228}${(%):-%~} %F{231}%#%E %F{254}'
