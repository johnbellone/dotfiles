#!/usr/bin/env zsh
setopt NO_BG_NICE
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS
setopt LOCAL_TRAPS
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

if command -v gls >/dev/null; then
    alias ls="gls -F --color=auto"
fi

alias l="ls -Cfh"
alias ll="ls -AclhsF"
alias la="ls -Ah"
alias sc="script/console"
alias st="git st"
alias gf="git fetch --all"
alias gm="git merge"
alias gp="git push"
alias pr="git pull --rebase"

alias grep="grep --color=auto"
alias psef="ps auxx|egrep -v '[g]rep'|grep -i"

autoload -U compinit promptinit
compinit
promptinit

PROMPT="%F{216}%~ %F{229}%# %f"
echo "uptime $(uptime)"

butcher() {
    for x; do
        knife node delete -y $x || true
        knife client delete -y $x || true
    done
}

[ -f /Users/jbellone/.travis/travis.sh ] && source /Users/jbellone/.travis/travis.sh
