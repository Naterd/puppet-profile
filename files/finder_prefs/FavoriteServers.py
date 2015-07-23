#!/usr/bin/python
# Add Favorite Servers to the "Connect to Server" dialog box
# Last modified July 23, 2015 - Burlison

import subprocess, sys
from Foundation import CFPreferencesAppSynchronize, \
                       CFPreferencesCopyAppValue, \
                       CFPreferencesSetMultiple, \
                       kCFPreferencesAnyHost, \
                       kCFPreferencesCurrentUser

prefs={'favoriteservers': {'Controller': 'CustomListItems', 'CustomListItems': [{'Name': 'smb://011-ctemac2', 'URL': 'smb://011-ctemac2'}]}}

CFPreferencesSetMultiple(
    prefs,
    [],
    'com.apple.sidebarlists',
    kCFPreferencesCurrentUser,
    kCFPreferencesAnyHost
)

CFPreferencesAppSynchronize('com.apple.sidebarlists')

command = ['/usr/bin/killall', 'Finder']
subprocess.call(command)