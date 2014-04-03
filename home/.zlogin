#!/usr/bin/env zsh
# Print out useful information about this machine.
echo "uptime $(uptime)"

# Print out some diagnostics on a login shell.
[ `command -v ruby >/dev/null` ] && echo "$(ruby --version)"
[ `command -v java >/dev/null` ] && echo "$(java -version 2>&1 | head -n2 | tail -n1)"
[ `command -v node >/dev/null` ] && echo "nodejs $(node --version) npm $(npm --version)"
[ `command -v go >/dev/null` ] && echo "$(go version)"
