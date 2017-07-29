#!/usr/bin/env bash
[ -f /usr/local/share/chruby/chruby.sh ] &&
    source /usr/local/share/chruby/chruby.sh

alias l="ls -Cfh"
alias ll="ls -AclhsF"
alias la="ls -Ah"
alias st="git status"
alias gf="git fetch --all"
alias gp="git push"
alias pr="git pull --rebase"
alias grep="grep --color=auto"
alias psef="ps auxx|grep -v '[g]rep'|grep -i"

export EDITOR="emacsclient -t"
export CLICOLOR=1
export LSCOLORS="gxBxhxDxfxhxhxhxhxcxcx"
export LS_COLORS='di=38;5;108:fi=00:*svn-commit.tmp=31:ln=38;5;116:ex=38;5;186'

export GOPATH=$HOME/go
export PATH=bin:$HOME/bin:$GOPATH/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/bin:/sbin

# Set up and configure the prompt.
ORANGE="\[$(tput setaf 216)\]"
YELLOW="\[$(tput setaf 229)\]"
RESET="\[$(tput sgr0)\]"
export PS1="$ORANGE\w $YELLOW\\$ $RESET"
echo "uptime $(uptime)"
