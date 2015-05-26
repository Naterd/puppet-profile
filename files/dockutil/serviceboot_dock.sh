#!/bin/sh

# server dock
osversionlong=`sw_vers -productVersion`
osvers=${osversionlong:3:1}
dockutil=/usr/local/bin/dockutil


dockutil --remove all --no-restart
sleep 2
dockutil --add /Applications/Safari.app --no-restart
dockutil --add /Applications/Utilities/Terminal.app --no-restart
dockutil --add /Applications/Utilities/Disk\ Utility.app --no-restart
dockutil --add /Applications/TextWrangler.app --no-restart
dockutil --add /Applications/Utilities/Activity\ Monitor.app --no-restart

dockutil --add '/Applications' --view grid --display folder --sort name --no-restart
dockutil --add '~/Documents' --view grid --display folder --sort name --no-restart
dockutil --add '~/Downloads' --view grid --display folder --sort dateadded