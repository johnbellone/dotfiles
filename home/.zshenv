#!/usr/bin/env zsh
typeset -U path
PATH=(bin ~/bin /usr/local/opt/coreutils/libexec/gnubin /usr/local/bin /usr/bin /usr/local/sbin /usr/sbin $PATH)
MANPATH=(/usr/local/opt/coreutils/libexec/gnuman $PATH)

# Automatically source chruby if it exists on disk and not already loaded up.
if ! command -v chruby > /dev/null; then
    [ -d /usr/local/share/chruby ] && . /usr/local/share/chruby/chruby.sh
fi

# If the Chef development kit exists on this system be sure to add it
# to the rubies. This is used for chruby support.
[ -d /opt/chefdk ] && RUBIES+=(/opt/chefdk/embedded)
