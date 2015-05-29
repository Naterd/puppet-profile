#!/bin/bash
set -x

if [ -e "${HOME}/Library/Preferences/com.adobe.Acrobat.Pro.plist"]
    /bin/cp /usr/local/outset/resources/AdobeAcceptEULA/com.adobe.Acrobat.Pro.plist ${HOME}/Library/Preferences/com.adobe.Acrobat.Pro.plist
fi

if [ -e "${HOME}/Library/Preferences/com.adobe.Reader.plist"]
    /bin/cp /usr/local/outset/resources/AdobeAcceptEULA/com.adobe.Reader.plist ${HOME}/Library/Preferences/com.adobe.Reader.plist
fi
exit 0