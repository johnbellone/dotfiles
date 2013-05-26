# -*- mode: sh -*-
# ~/.bash_profile

# Source all of additional files if they're sitting around.
[ -f $HOME/.bashrc ] && source $HOME/.bashrc
[ -f $HOME/.javarc ] && source $HOME/.javarc
[ -f $HOME/.rubyrc ] && source $HOME/.rubyrc
[ -f $HOME/.jsrc ] && source $HOME/.jsrc

# Print out some diagnostics on a login shell.
[ -f $RUBY_PATH ] && echo "$(ruby --version)"
[ -f $JAVA_PATH ] && echo "$(java -version 2>&1 | head -n2 | tail -n1)"
[ -f $NODE_PATH ] && echo "node $(node --version)"
[ -f $NPM_PATH ] && echo "npm $(npm --version)"

# Finally, print out our uptime of this machine.
echo "$(uptime)"
