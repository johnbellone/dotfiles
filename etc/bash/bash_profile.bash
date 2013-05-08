# -*- mode: sh -*-
# ~/.bash_profile

# Source all of additional files if they're sitting around.
if [ -f $HOME/.javarc ]; then . $HOME/.javarc; fi
if [ -f $HOME/.rubyrc ]; then . $HOME/.rubyrc; fi
if [ -f $HOME/.bashrc ]; then . $HOME/.bashrc; fi

# Print out some diagnostics on a login shell.
if [ -f $RUBY_PATH ]; then echo "$(ruby --version)"; fi
if [ -f $JAVA_PATH ]; then echo "$(java -version 2>&1 | head -n2 | tail -n1)"; fi

# Finally, print out our uptime of this machine.
echo "$(uptime)"
