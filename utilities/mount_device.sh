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
# The script will not send output because it is made to be 
# used with the crontab to detect the device
#
########################################################## CHANGELOG
#
# Version 1.0:
#   - Support to mount one device automatically
#   - Allow to choose if the user will want to identify
#     the device from label or uuid.
#
# Version 1.1:
#   - Code refactored: Now uses case instead of if's 
#
########################################################## 


########################################################## CONFIG

# Put the content inside one of them or both it will be used
# to Identify the device
UUID=''
LABEL=''

# Do not modify the version number
VERSION='1.1'

########################################################## START

# Must be root to work with filesystem
[ $UID -ne 0 ] && exit 1

case "$1" in
  
  -v|--version)
    echo "Version $VERSION"
  ;;

  # Two blocks depending on the option used if by UUID or LABEL
 -u|--uuid)
    DIRECTORY="$HOME/$UUID"
    findfs UUID="${UUID}" 1>/dev/null 2>&1 || exit 1
    mkdir -p "$DIRECTORY"
    mount $(findfs UUID=$UUID) "$DIRECTORY"
  ;;

  
  -l|--label)
    DIRECTORY="$HOME/$LABEL"
    findfs LABEL=${LABEL} 1>/dev/null 2>&1 || exit 1
    mkdir -p "$DIRECTORY"
    mount $(findfs LABEL=$LABEL) "$DIRECTORY"
  ;;

  
  *)  
  echo '
  Usage: ./mount_device.sh [OPTIONS]

  OPTIONS:
    -v | --version  get the version of the script
    -h | --help     get help
    -u | --uuid     use the UUID to identify the device
    -l | --label    use the LABEL to identify the device

  CONFIGURATION:
    Run the command:
    lsblk -o name,uuid,label,size

    after that you select or the label or the uuid,
    both are used to recognize the device

    Open the script and then set the UUID or LABEL
    variable with the device you want.

    The device will be mounted in the home of the user.
  '
  ;;

esac
