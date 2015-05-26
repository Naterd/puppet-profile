#!/bin/sh

# District default dock
osversionlong=`sw_vers -productVersion`
osvers=${osversionlong:3:1}
dockutil=/usr/local/bin/dockutil


dockutil --remove all --no-restart
sleep 2
dockutil --add /Applications/Launchpad.app --no-restart
dockutil --add /Applications/Mission\ Control.app --no-restart
dockutil --add /Applications/App\ Store.app --no-restart
dockutil --add /Applications/Mail.app --no-restart
dockutil --add /Applications/Chrome.app --no-restart
dockutil --add /Applications/Safari.app --no-restart

if [ -d "/Applications/Calendar.app" ]; then
  dockutil --add /Applications/Calendar.app --no-restart
fi

if [ -d "/Applications/iCal.app" ]; then
  dockutil --add /Applications/iCal.app --no-restart
fi

dockutil --add /Applications/iTunes.app --no-restart
dockutil --add /Applications/Microsoft\ Office\ 2011/Microsoft\ Excel.app --no-restart
dockutil --add /Applications/Microsoft\ Office\ 2011/Microsoft\ PowerPoint.app --no-restart
dockutil --add /Applications/Microsoft\ Office\ 2011/Microsoft\ Word.app --no-restart
dockutil --add /Applications/Managed\ Software\ Center.app --no-restart
dockutil --add /Applications/System\ Preferences.app --no-restart

dockutil --add '/Applications' --view grid --display folder --sort name --no-restart
dockutil --add '~/Documents' --view grid --display folder --sort name --no-restart
dockutil --add '~/Downloads' --view grid --display folder --sort dateadded