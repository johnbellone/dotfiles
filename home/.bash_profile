# -*- mode: sh -*-
# ~/.bash_profile

# HACK: Because how rbenv (and I assume nodenv) shims work the versions were
# being screwed up because how tmux launches subshells. This resets the PATH
# so that we avoid duplicates.
[ -z "$TMUX" ] || export PATH=/usr/local/bin:/usr/bin:/bin

# Source the local profile for any specific changes that should only
# be loaded up in an interactive shell.
[ -f $HOME/.profile ] && source $HOME/.profile

# Figure out the proper path for all optional software.
[ `which brew 2>/dev/null` ] && HOMEBREW_PATH=$(brew --prefix)
OPT_PATH=${HOMEBREW_PATH:-/usr/local}

# Source all of additional files if they're sitting around.
[ -f $HOME/.bashrc ] && source $HOME/.bashrc

# If the system has bash-completion installed attempt to source it.
[ -f $OPT_PATH/etc/bash_completion ] && source $OPT_PATH/etc/bash_completion

# Print out useful information about this machine.
echo "uptime $(uptime)"

# Print out some diagnostics on a login shell.
[ `which ruby 2>/dev/null` ] && echo "$(ruby --version)"
[ `which java 2>/dev/null` ] && echo "$(java -version 2>&1 | head -n2 | tail -n1)"
[ `which node 2>/dev/null` ] && echo "nodejs $(node --version) npm $(npm --version)"
[ `which go 2>/dev/null` ] && echo "$(go version)"

# Display a custom bash prompt.
[ -f $HOME/.bash_prompt ] && source $HOME/.bash_prompt
