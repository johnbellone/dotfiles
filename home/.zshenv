#!/usr/bin/env zsh
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000

path=(bin $HOME/bin/$MACTYPE-$OSTYPE $HOME/bin /usr/local/bin /usr/bin /usr/local/sbin /usr/sbin /bin /sbin)
export EDITOR="emacsclient -t"
export CLICOLOR=1
export LSCOLORS="gxBxhxDxfxhxhxhxhxcxcx"
export LS_COLORS='di=38;5;108:fi=00:*svn-commit.tmp=31:ln=38;5;116:ex=38;5;186'

# Set up environmnet for Go development (and running binaries from `go get`).
export GOPATH=$HOME/go
[ -d $GOPATH ] && \
    path+=("$GOPATH/bin")

# Handle homebrew on OSX installing coreutils into an alternate directory.
[ -d /usr/local/opt/coreutils/libexec/gnubin ] && \
    path+=(/usr/local/opt/coreutils/libexec/gnubin)
[ -d /usr/local/opt/coreutils/libexec/gnuman ] && \
    manpath=/usr/local/opt/coreutils/libexec/gnuman
[ -d /Library/TeX/texbin ] && \
    path+=(/Library/TeX/texbin)

typeset -U path MANPATH RUBIES EDITOR
