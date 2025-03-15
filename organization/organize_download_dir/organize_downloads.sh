#!/usr/bin/env sh


# DISCLAIMER:
# Usually it wont change much since sh is a link to bash
# in a lot of distributions, but you can change it to dash
# which will improve its speed and lower the overhead

################################################# HEADER
#
#	Organize downloads
#	description: separates the files according
#	to the extension to a better Downloads
#	folder
#
#
#	Creator: Joao Mauricio
#	github: github.com/jean0t
#
#   Last update: 24-02-2025
#
################################################# INFO
#
#	Compatibility POSIX
#
#	Tested Dash and Korn shell
#	(also bash and zsh, but they are guaranteed
#	to work if dash can run it anyway)
#
#
################################################# CONFIGURATIONS

# This script scans your downloads directory to see if there is any new file
# if there is, it will move to the correspondent directory, be it audios, videos or anything else


#Directories
download_dir="$HOME/Downloads"
images_dir="$download_dir/images"
texts_dir="$download_dir/texts"
binaries_dir="$download_dir/binaries"
audio_dir="$download_dir/audio"
videos_dir="$download_dir/videos"
special_dir="$download_dir/special"


################################################# VERIFICATION


# if the user leaves with Ctrl+C it wont release an Error
trap 'exit 0' INT


# creates the directories if it don't exist
for dir in "$images_dir" "$texts_dir" "$binaries_dir" "$audio_dir" "$special_dir" "$videos_dir"
do
    if test ! -e "$dir"
    then
        mkdir -p "$dir"
    fi
done

################################################# FUNCTION


# receives a directory as parameter and organizes the files in directories
organize_files() {

    # Leaves if something unexpected happen with cd
    # it won't happen, but you never know :P
	cd "$1" || exit 1 
	IFS='
'
	for file in *; do

		[ -d "$file" ] && continue # if it is a directory, ignores

        case "$(file --mime-type -b "$file")" in
				image/*)
					mv "$file" "$images_dir"
					echo "$file moved to $images_dir"
				;;

				text/*)
					mv "$file" "$texts_dir"
					echo "$file moved to $texts_dir"
				;;

				audio/*)
					mv "$file" "$audio_dir"
					echo "$file moved to $audio_dir"
				;;

				application/*)
					mv "$file" "$binaries_dir"
					echo "$file moved to $binaries_dir"
				;;

				video/*)
					mv "$file" "$videos_dir"
					echo "$file moved to $videos_dir"
				;;

				*)
					mv "$file" "$special_dir"
					echo "$file moved to $special_dir"
				;;
			esac
		done
		unset IFS
	}

################################################# START

organize_files "$download_dir"
