#!/bin/bash

# For more info: https://github.com/jacobsalmela/NCutil

#Suppress Apple Update Notifications Like The "Free Yosemite Upgrade"
/usr/local/bin/NCutil.py -a _SYSTEM_CENTER_:com.apple.storeagent none
/usr/local/bin/NCutil.py -a _SYSTEM_CENTER_:com.apple.noticeboard none

#Disabling the App Store Notifications 
/usr/local/bin/NCutil.py --alerts com.apple.maspushagent none

exit 0