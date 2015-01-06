#!/usr/bin/env zsh
path=(bin $HOME/bin/$MACHTYPE-$OSTYPE $HOME/bin /usr/local/bin /usr/bin /usr/local/sbin /usr/sbin /bin /sbin)

# Handle homebrew on OSX installing coreutils into an alternate directory.
[ -d /usr/local/opt/coreutils/libexec/gnubin ] && \
    path+=(/usr/local/opt/coreutils/libexec/gnubin)
[ -d /usr/local/opt/coreutils/libexec/gnuman ] && \
    MANPATH+=(/usr/local/opt/coreutils/libexec/gnuman)

# Automatically source chruby if it exists on disk and not already loaded up.
if ! command -v chruby > /dev/null; then
    [ -d /usr/local/share/chruby ] && . /usr/local/share/chruby/chruby.sh
fi

# If the Chef development kit exists on this system be sure to add it
# to the rubies. This is used for chruby support.
[ -d /opt/chefdk ] && RUBIES+=(/opt/chefdk/embedded)

EDITOR='emacsclient -t'

typeset -U path MANPATH RUBIES EDITOR
