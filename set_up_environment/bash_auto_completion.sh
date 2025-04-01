#!/usr/bin/env bash

# unfortunatelly you must be root to do any action in /etc
[ "$UID" -ne 0 ] && { printf "%s\n" "You must be root to run this script" ; exit 1 ; }


USER_FILE="$HOME/.inputrc"
cat /etc/inputrc > "$USER_FILE"
echo 'set completion-ignore-case on' >> "$USER_FILE"
echo 'set show-all-if-ambiguous on' >> "$USER_FILE"
