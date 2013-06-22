# -*- mode: sh -*-
# ~/.bash_profile

# Source the local profile for any specific changes that should only
# be loaded up in an interactive shell.
[ -f $HOME/.profile ] && source $HOME/.profile

# Source all of additional files if they're sitting around.
[ -f $HOME/.bashrc ] && source $HOME/.bashrc

# Figure out the proper path for all optional software.
[ `which brew &>/dev/null` ] && HOMEBREW_PATH=$(brew --prefix)
OPT_PATH=${HOMEBREW_PATH:-/usr/local}

# If the system has bash-completion installed attempt to source it.
[ -f $OPT_PATH/etc/bash_completion ] && source $OPT_PATH/etc/bash_completion

# Print out useful information about this machine.
echo "uptime $(uptime)"

# Print out some diagnostics on a login shell.
[ `which ruby` ] && echo "$(ruby --version)"
[ `which java` ] && echo "$(java -version 2>&1 | head -n2 | tail -n1)"
[ `which node` ] && echo "nodejs $(node --version) npm $(npm --version)"
