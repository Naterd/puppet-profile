#!/bin/sh
PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/libexec export PATH

# server dock
dockutil --remove all --no-restart
sleep 2
dockutil --add /Applications/Mission\ Control.app --no-restart
dockutil --add /Applications/Firefox.app --no-restart
dockutil --add /Applications/Safari.app --no-restart
dockutil --add /Applications/Carbon\ Copy\ Cloner.app --no-restart
dockutil --add /Applications/Server.app --no-restart
dockutil --add /Applications/Utilities/DeployStudio\ Admin.app --no-restart
dockutil --add /Applications/Workgroup\ Manager.app --no-restart
dockutil --add /Applications/SourceTree.app --no-restart
dockutil --add /Applications/Sequel\ Pro.app --no-restart
dockutil --add /Applications/Utilities/Terminal.app --no-restart
dockutil --add /Applications/Utilities/Disk\ Utility.app --no-restart
dockutil --add /Applications/TextWrangler.app --no-restart
dockutil --add /Applications/Utilities/Activity\ Monitor.app --no-restart
dockutil --add /Applications/Managed\ Software\ Center.app --no-restart
dockutil --add /Applications/System\ Preferences.app --no-restart

dockutil --add '/Applications' --display folder --sort name --no-restart
dockutil --add '~/Documents' --display folder --sort name --no-restart
dockutil --add '~/Downloads' --display folder --sort dateadded