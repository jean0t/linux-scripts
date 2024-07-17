#!/usr/bin/env bash

#============================================|
#	Downloads youtube audio
#	created by: Jean0t
#	github: github.com/jean0t
#	version: 1.0
#============================================|
#	Changelog
#
#	1.0:
#		- Downloads and extracts audios
#		  from youtube videos
#
#============================================|

#============================================|
# VERIFICATIONS

# Do not allow root to run
[[ "$UID" -eq '0' ]] && { echo 'Do not run as root' ; exit 1 ; }

# test if the necessary module exist
[[ $( type -p yt-dlp ) ]] || { echo 'yt-dlp not found.' ; exit 1 ; }

# Test internet conection
[[ $( ping -c1 8.8.8.8 ) ]] || { echo 'You need internet conection to run the script' ; exit 1 ; }

# test if the directory exists
[[ ! -e "$HOME/Downloads/Youtube_Download" ]] \
&& { echo 'created directory ~Downloads/Youtube_Download' ; mkdir -p "$HOME/Downloads/Youtube_Download" ; }

#============================================|
# GLOBAL VARIABLES
version='1.0'
quality='128k' #supports 64k, 128k, 256k, 320k
format='mp3' #supports best, aac, vorbis, m4a, opus, wav
output_directory="$HOME/Downloads/Youtube_Download/%(title)s.%(ext)s"
#============================================|

#	START THE PROGRAM

echo 'Starting the download...'
if [[ $( yt-dlp -x -f bestaudio -o "$output_directory" --embed-thumbnail "$@" ) ]]; then
	echo 'Download was successful'
	exit 0
else
	echo 'An error has occurred'
	exit 1
fi
