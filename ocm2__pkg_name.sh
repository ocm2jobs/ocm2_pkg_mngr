#!/bin/bash 

yellow="\e[33m"
ARGS="$*"
if echo $ARGS | grep -qE "^([a-zA-Z0-9_\-\+\.]+/[a-zA-Z0-9_\-\+\.]+)"; then
   APP_DESC="application"
 else
   APP_DESC="description"
fi

PKG_NAME=$(echo $1 | sed -e 's/[[:alpha:]]*\///' | cut -d' ' -f1)

echo -e "$yellow"

if [ "$APP_DESC" == "application" ]; then
  # [ ! pacman -Qi $PKG_NAME 2>/dev/null ] || echo -en "${APP_DESC~} :: $ARGS\n\n"
  if ! pacman -Qi $PKG_NAME 2>/dev/null; then
  #  echo -en "${APP_DESC~} :: 
     pacman -Ss $PKG_NAME | grep -A1 "$(echo $1|cut -d' ' -f1)"
  fi
else
  PKG_NAME=$(echo $ARGS | cut -d' ' -f1-2)
  echo -en "${APP_DESC~} :: $ARGS\n"
  echo -en "Search      :: $PKG_NAME\n"
  echo -e "$yellow" ; pacman -Ss "$PKG_NAME" | grep -B1 "$PKG_NAME"
fi
