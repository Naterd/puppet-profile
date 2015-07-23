#!/bin/sh

sidebarid=`/usr/bin/profiles -L -v | /usr/bin/grep -o 'com.apple.sidebarlists' | /usr/bin/head -1`

/usr/bin/profiles -R -p $sidebarid

finderid=`/usr/bin/profiles -L -v | /usr/bin/grep -o 'com.apple.finder' | /usr/bin/head -1`

/usr/bin/profiles -R -p $finderid