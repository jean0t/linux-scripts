#!/usr/bin/env bash


########################################################## HEADER
#
# Author: Joao Mauricio
# Github: Jean0t
#
# License: GPL-3
#
########################################################## INFO
#
# Compatibility: Bash and Zsh
#
# This script Goal is to allow automate mounting points
# to flash drives
#
########################################################## CHANGELOG
#
# Version 1.0:
#   - Support to mount one device automatically
#   - Allow to choose if the user will want to identify
#     the device from label or uuid.
#
#
########################################################## HELPER

if [ "${1}" = '-v' ] || [ "${1}" = "--version" ] ; then
  echo 'version 1.0'
  exit 0 
fi

if [ "${1}" = '-h' ] || [ "${1}" = '--help' ] ; then
  echo "
  Usage: ./mount_device.sh [OPTIONS]

  OPTIONS:
    -v | --version  get the version of the script
    -h | --help     get help

  CONFIGURATION:
    Run the command \`lsblk -o name,uuid,label,size\`
    after that you select or the label or the uuid,
    both are used to recognize the device

    Open the script and then set the UUID or LABEL
    variable with the device you want.

    The device will be mounted in the home of the user.
"
  exit 0
fi

########################################################## CONFIG

# Put the content inside the 'here'
UUID=''
LABEL=''

########################################################## START

# Must be root to work with filesystem
[ $UID -ne 0 ] && exit 1

# Two blocks depending on the option used if by UUID or LABEL
if [ -n $UUID ]; then
  DIRECTORY="$HOME/$UUID"
  findfs UUID="${UUID}" 1>/dev/null 2>&1 || exit 1
  mkdir -p "$DIRECTORY"
  mount $(findfs UUID=$UUID) "$DIRECTORY"
fi

if [ -n $LABEL ]; then
  DIRECTORY="$HOME/$LABEL"
  findfs LABEL=${LABEL} 1>/dev/null 2>&1 || exit 1
  mkdir -p "$DIRECTORY"
  mount $(findfs LABEL=$LABEL) "$DIRECTORY"
fi
