#!/usr/bin/env sh

########################################################### HEADER
#
#   Creator: Joao Mauricio (Jean0t)
#   Date: 20-02-2025 (dd-mm-yyyy)
#   
#   purpose: make it easy to install appimages
#
###########################################################

########################################################### CHANGELOG
#
#   1.0 :
#       script created, supports 1 executable each time
#       command line usage
#
#   2.0 :
#       POSIX compliant
###########################################################
VERSION='2.0'


########################################################### INFO
# 
# The desktop entry will have the fields:
# Name,Comment,GenericName,Icon,Exec
# Mandatory to have Name,Icon,Exec
#
###########################################################


########################################################### SET UP

# Works to collect the info needed
while [ -n "$1" ]; do
    case "$1" in
        -n|--name)
            shift
            NAME="$1"
            shift
        ;;

        -d|--description)
            shift
            DESCRIPTION="$1"
            shift
        ;;

        -i|--icon)
            shift
            ICON="$(realpath "$1")"
            shift
        ;;

        -gn|--generic-name)
            shift
            GENERICNAME="$1"
            shift
        ;;

        -e|--exec)
            shift
            EXEC="$(realpath "$1")"
            shift
        ;;

        -v|--version)
            echo "Version $VERSION"
            exit 0
        ;;

        *)  # help section
            echo 'Usage:
    ./desktop_entry_creator.sh --name file.appimage --icon icon.png --exec /path/to/file.appimage

    OPTIONS:
         -n|--name           defines the name of the app
         -d|--description    defines the description
        -gn|--generic-name  a generic name (example: web browser)
         -e|--exec           path to the executable
         -i|--icon           path to the icon image
         -v|--version        version of the script

the parameter name, exec and icon are required to work, otherwise the script will return an error.
Default directory: $HOME/.local/share/applications'
            exit 0
        ;;
    esac
done

[ -z "$NAME" ] && exit 1
[ -z "$ICON" ] && exit 1
[ -z "$EXEC" ] && exit 1

########################################################### VARIABLES
TEMPLATE="[Desktop Entry]
Name=$NAME
Type=Application
GenericName=$GENERICNAME
Comment=$DESCRIPTION
Icon=$ICON
Exec=$EXEC
"

OUTPUTDIR="$HOME/.local/share/applications"

# name treated to have only lowercase letters and no spaces
NAMEFILE="$(echo "$NAME" | tr '[:upper]' '[:lower:]' | tr ' ' _)"
###########################################################


########################################################### START

# If there is some mysterious error here the variables expansion
# will take of of it to avoid rewritting some important file
echo "$TEMPLATE" > "${OUTPUTDIR:-/nothing}"/"${NAMEFILE:-nothing}.desktop"
