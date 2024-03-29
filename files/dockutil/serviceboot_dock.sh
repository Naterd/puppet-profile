#!/bin/sh
PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/libexec export PATH

# server dock
dockutil --remove all --no-restart
sleep 2
dockutil --add /Applications/Safari.app --no-restart
dockutil --add /Applications/Utilities/Terminal.app --no-restart
dockutil --add /Applications/Utilities/Disk\ Utility.app --no-restart
dockutil --add /Applications/TextWrangler.app --no-restart
dockutil --add /Applications/Utilities/Activity\ Monitor.app --no-restart

dockutil --add '/Applications' --display folder --sort name --no-restart
dockutil --add '~/Documents' --display folder --sort name --no-restart
dockutil --add '~/Downloads' --display folder --sort dateadded