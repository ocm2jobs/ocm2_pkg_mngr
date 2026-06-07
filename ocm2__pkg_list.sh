#!/bin/bash 
# Process pkg list from pacman -Ql <PKG_NAME>
#
# set -x

ARGS="$*"
yellow="\e[33m"
echo -en "$yellow"

[ -z "$ARGS" ] && exit 

ARG=$(echo $ARGS | cut -d' ' -f2)
TYPE="$(file $ARG)"
echo $TYPE
case "$TYPE" in
  *"ASCII text"*)
    head -n100 $ARG
    ;;
  *"directory"*)
    tree -d $ARG
    ;;
  # *"ELF 64-bit LSB pie executable"*) 
  #  ;;
  *) 
    echo -en "\n\n"
    eza --color=always --icons=always --git --all --long --sort=created $ARG
    ;;
esac

