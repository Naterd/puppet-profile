#!/bin/sh
# Enable right click on Mouse. Yosemite doesn't respect profiles for this setting.

/usr/bin/defaults write "~/Library/Preferences/com.apple.driver.AppleHIDMouse" Button2 -int 2
/usr/bin/defaults write "~/Library/Preferences/com.apple.driver.AppleBluetoothMultitouch.mouse" MouseButtonMode -string TwoButton
/usr/bin/defaults write "~/Library/Preferences/com.apple.driver.AppleBluetoothMultitouch.trackpad" TrackpadRightClick -int 1
exit 0