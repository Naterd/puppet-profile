#!/bin/sh

# Audio Video Dock
osversionlong=`sw_vers -productVersion`
osvers=${osversionlong:3:1}
dockutil=/usr/local/bin/dockutil

dockutil --remove all --no-restart
sleep 2
dockutil --add /Applications/Launchpad.app --no-restart
dockutil --add /Applications/Mission\ Control.app --no-restart
dockutil --add /Applications/Chrome.app --no-restart
dockutil --add /Applications/Safari.app --no-restart
dockutil --add /Applications/Adobe\ After\ Effects\ CC\ 2014/Adobe\ After\ Effects\ CC\ 2014.app --no-restart
dockutil --add /Applications/Adobe\ Photoshop\ CC\ 2014/Adobe\ Photoshop\ CC\ 2014.app --no-restart
dockutil --add /Applications/Adobe\ Premiere\ Pro\ CC\ 2014/Adobe\ Premiere\ Pro\ CC\ 2014.app --no-restart

if [ -d "/Applications/Logic\ Pro.app" ]; then
  dockutil --add /Applications/Logic\ Pro.app --no-restart
fi

if [ -d "/Applications/Calendar.app" ]; then
  dockutil --add /Applications/Calendar.app --no-restart
fi

if [ -d "/Applications/iCal.app" ]; then
  dockutil --add /Applications/iCal.app --no-restart
fi

dockutil --add /Applications/GarageBand.app --no-restart
dockutil --add /Applications/iPhoto.app --no-restart
dockutil --add /Applications/Celtx.app --no-restart
dockutil --add /Applications/iTunes.app --no-restart

if [ -d "/Applications/Keynote.app" ]; then
  dockutil --add /Applications/Keynote.app --no-restart
fi

if [ -d "/Applications/Numbers.app" ]; then
  dockutil --add /Applications/Numbers.app --no-restart
fi

if [ -d "/Applications/Pages.app" ]; then
  dockutil --add /Applications/Pages.app  --no-restart
fi


dockutil --add /Applications/App\ Store.app --no-restart
dockutil --add /Applications/Managed\ Software\ Center.app --no-restart
dockutil --add /Applications/System\ Preferences.app --no-restart

dockutil --add '/Applications' --view grid --display folder --no-restart --sort name
dockutil --add '~/Documents' --view grid --display folder --no-restart --sort name
dockutil --add '~/Downloads' --view grid --display folder --no-restart --sort dateadded
dockutil --add smb://011-ctemac2 --label '011-ctemac2' --no-restart
dockutil --add smb://studiob:bisdtv@011-ctemac2/Upchurch --label 'Upchurch' --no-restart
dockutil --add smb://studiob:bisdtv@011-ctemac2/Kasal --label 'Kasal'