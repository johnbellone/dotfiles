# -*- mode: sh -*-
# ~/.bash_aliases

# NOTE: This is mainly due to the fact that BSD (Mac OS X) ships with
# a different toolchain. At some point it'd be nice to actually have
# the GNU tools for everything.
case $OSTYPE in
    Linux)
        alias ls='ls --color=auto'
        ;;
    darwin12|darwin10.0)
        export CLICOLOR=1
        export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
        ;;
    *)
        ;;
esac

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
alias bp="b package"
alias gb="gem build"
alias sc="script/console"
alias rc="be rails console"
alias pr="git pull --rebase"
alias prp="pr && git push"
alias d="git diff"
alias st="git st"
alias k="kill -9"

# Make sure that my grep is colorized.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Some additional utility aliases.
alias stalk="ps auxx | grep -v 'grep --color=auto -i' | grep -i"
alias df='df | column -t'
alias du='du -H'
