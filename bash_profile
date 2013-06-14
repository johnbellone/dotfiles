# -*- mode: sh -*-
# ~/.bash_profile

# Print out useful information about this machine.
echo "uptime $(uptime)"

# Source all of additional files if they're sitting around.
[ -f $HOME/.bashrc ] && source $HOME/.bashrc

# Print out some diagnostics on a login shell.
[ -f $RUBY_PATH ] && echo "$(ruby --version)"
[ -f $JAVA_PATH ] && echo "$(java -version 2>&1 | head -n2 | tail -n1)"
[ -f $NODE_PATH ] && [ -f $NPM_PATH ] && echo "nodejs $(node --version) npm $(npm --version)"
