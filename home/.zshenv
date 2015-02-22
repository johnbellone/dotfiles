#!/usr/bin/env zsh
path=(bin $HOME/bin/$MACHTYPE-$OSTYPE $HOME/bin /usr/local/bin /usr/bin /usr/local/sbin /usr/sbin /bin /sbin)

# Handle homebrew on OSX installing coreutils into an alternate directory.
[ -d /usr/local/opt/coreutils/libexec/gnubin ] && \
    path+=(/usr/local/opt/coreutils/libexec/gnubin)
[ -d /usr/local/opt/coreutils/libexec/gnuman ] && \
    MANPATH+=(/usr/local/opt/coreutils/libexec/gnuman)

# Automatically source chruby if it exists on disk and not already loaded up.
if ! command -v chruby > /dev/null; then
    if [ -d /usr/local/share/chruby ]; then
        . /usr/local/share/chruby/chruby.sh
    elif [ -d /usr/local/opt/chruby ]; then
        . /usr/local/opt/chruby/share/chruby/chruby.sh
    fi
fi

EDITOR='emacsclient -t'

typeset -U path MANPATH RUBIES EDITOR
