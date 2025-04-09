#!/usr/bin/env bash

# path to the file in the home directory of the user
USER_FILE="$HOME/.inputrc"

# retrieve contents
cat /etc/inputrc > "$USER_FILE"

# make the magic happens, allows the insensitive case completion
echo 'set completion-ignore-case on' >> "$USER_FILE"
echo 'set show-all-if-ambiguous on' >> "$USER_FILE"
