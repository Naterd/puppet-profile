#!/bin/sh

CURRENT_USER=`/bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }'`
PREFS_SRC="/Library/Application Support/Google/Chrome/Default/Preferences"
PREFS_TGT_DIR="/Users/$CURRENT_USER/Library/Application Support/Google/Chrome/Default"
PREFS_TGT_FILE="$PREFS_TGT_DIR/Preferences"

# make our user's chrome profile dir if one doesn't already exist
[ -d "$PREFS_TGT_DIR" ] || mkdir -p "$PREFS_TGT_DIR"

# if prefs file doesn't already exist, copy it
[ -e "$PREFS_TGT_FILE" ] || cp "$PREFS_SRC" "$PREFS_TGT_FILE"

# yeah thanks
touch "$PREFS_TGT_DIR/../First Run"

# fix preferences
chown -R $CURRENT_USER:admin ${PREFS_TGT_DIR}
chmod 600 $PREFS_TGT_FILE
chmod 640 "$PREFS_TGT_DIR/../First Run"