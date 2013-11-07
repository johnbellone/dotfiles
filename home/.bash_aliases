# -*- mode: sh -*-
# ~/.bash_aliases

# For the most part I install GNU coreutils on most of my setups.
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export LS_COLORS='di=38;5;108:fi=00:*svn-commit.tmp=31:ln=38;5;116:ex=38;5;186'

# Directory listing made easy.
alias ll='ls -AclhsF'
alias la='ls -Ah'
alias l='ls -CFh'

# Rails specific stuff.
alias b="bundle"
alias bi="b install"
alias bil="bi --local"
alias bils="bil --binstubs"
alias be="b exec"
alias bu="b update"
alias bp="b package"
alias gb="gem build"
alias sc="script/console"
alias rc="be rails console"
alias pr="git pull --rebase"
alias rp="pr && git push"
alias d="git diff"
alias st="git st"
alias k="kill -9"
alias gp='git push'
alias gf='git fetch --all'

alias em='emacs -nw'
alias ec='emacsclient -t'

# Make sure that my grep is colorized.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Some additional utility aliases.
alias stalk="ps auxx | grep -v 'grep --color=auto -i' | grep -i"
alias du='du -H'
