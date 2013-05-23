# -*- mode: sh -*-
# ~/.bash_aliases

# NOTE: This is mainly due to the fact that BSD (Mac OS X) ships with
# a different toolchain. At some point it'd be nice to actually have
# the GNU tools for everything.
case $OSTYPE in
    Linux)
        alias ls='ls --color=auto'
        ;;
    darwin10.0)
        export CLICOLOR=1
        export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
        ;;
    *)
        ;;
esac

# Directory listing made easy.
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Rails specific stuff.
alias rc="rails console"
alias sc="script/console"
alias b="bundle"
alias bi="bundle install"
alias bil="bundle install --local"
alias bis="bundle install --binstubs"

# Make sure that my grep is colorized.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Some additional utility aliases.
alias stalk="ps auxx | grep -v 'grep --color=auto -i' | grep -i"
alias df='df | column -t'
alias du='du -H'
