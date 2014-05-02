#!/usr/bin/env zsh
typeset -U path
path=(bin ~/bin /usr/local/opt/coreutils/libexec/gnubin /usr/local/bin /usr/bin /usr/local/sbin /usr/sbin $path)
manpath=(/usr/local/opt/coreutils/libexec/gnuman $path)

# Automatically source chruby if it exists on disk and not already loaded up.
if ! command -v chruby > /dev/null; then
    [ -d /usr/local/share/chruby ] && {
        . /usr/local/share/chruby/chruby.sh

    }
fi
