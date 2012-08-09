$BASH=$HOME/dotfiles

source etc/env.sh
source etc/aliases.sh

export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

if [[ -s /Users/jbellone/.rvm/scripts/rvm ]] ; then source /Users/jbellone/.rvm/scripts/rvm ; fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
