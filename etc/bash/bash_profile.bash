# -*- mode: sh -*-
# ~/.bash_profile

# Source all of additional files if they're sitting around.
[ -f $HOME/.javarc ] && source $HOME/.javarc
[ -f $HOME/.rubyrc ] && source $HOME/.rubyrc
[ -f $HOME/.bashrc ] && source $HOME/.bashrc

# Print out some diagnostics on a login shell.
[ -f $RUBY_PATH ] && echo "$(ruby --version)"
[ -f $JAVA_PATH ] && echo "$(java -version 2>&1 | head -n2 | tail -n1)"

# Finally, print out our uptime of this machine.
echo "$(uptime)"
