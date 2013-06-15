# -*- mode: sh -*-
# ~/.bash_profile

BOXEN_PATH=/opt/boxen

# Print out useful information about this machine.
echo "uptime $(uptime)"

# Source all of additional files if they're sitting around.
[ -f $HOME/.bashrc ] && source $HOME/.bashrc

# If this machine has been provisioned with Boxen make sure to
# include that environment properly.
[ -f $BOXEN_PATH/env.sh ] && source $BOXEN_PATH/env.sh

# Print out some diagnostics on a login shell.
[ -d $RBENV_ROOT ] && echo "$(ruby --version)"
[ -d $JAVA_HOME ] && echo "$(java -version 2>&1 | head -n2 | tail -n1)"
[ -d $NODENV_ROOT ] && echo "nodejs $(node --version) npm $(npm --version)"
