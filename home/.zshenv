#!/usr/bin/env zsh
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000

path=(bin $HOME/bin/$MACTYPE-$OSTYPE $HOME/bin /usr/local/bin /usr/bin /usr/local/sbin /usr/sbin /bin /sbin)
export EDITOR="emacsclient -t"
export CLICOLOR=1
export LSCOLORS="gxBxhxDxfxhxhxhxhxcxcx"
export LS_COLORS='di=38;5;108:fi=00:*svn-commit.tmp=31:ln=38;5;116:ex=38;5;186'

# Handle homebrew on OSX installing coreutils into an alternate directory.
[ -d /usr/local/opt/coreutils/libexec/gnubin ] && \
    path+=(/usr/local/opt/coreutils/libexec/gnubin)
[ -d /usr/local/opt/coreutils/libexec/gnuman ] && \
    manpath=/usr/local/opt/coreutils/libexec/gnuman
[ -d /Library/TeX/texbin ] && \
    path+=(/Library/TeX/texbin)

# Automatically source chruby if it exists on disk and not already loaded up.
if ! command -v chruby > /dev/null; then
    if [ -d /usr/local/share/chruby ]; then
        . /usr/local/share/chruby/chruby.sh
    elif [ -d /usr/local/opt/chruby ]; then
        . /usr/local/opt/chruby/share/chruby/chruby.sh
    fi
fi

typeset -U path MANPATH RUBIES EDITOR
