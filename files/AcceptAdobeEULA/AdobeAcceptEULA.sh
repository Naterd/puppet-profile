#!/bin/bash
set -x
mkdir -p ~/Library/Preferences/

/bin/cp /usr/local/outset/resources/AdobeAcceptEULA/com.adobe.Acrobat.Pro.plist ~/Library/Preferences/com.adobe.Acrobat.Pro.plist
/bin/cp /usr/local/outset/resources/AdobeAcceptEULA/com.adobe.Reader.plist ~/Library/Preferences/com.adobe.Reader.plist
exit 0