#!/usr/bin/env bash

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


# creates the directories if they don't exist
if [[ -e "$texts_dir" ]] && [[ -e "$images_dir" ]] && [[ -e "$special_dir" ]]; then
	mkdir -p "$images_dir" "$texts_dir" "$binaries_dir" "$audio_dir" "$special_dir"
fi


organize_files() {

	for file in $(cd "$1"; ls); do

		[[ -d "$file" ]] && continue # if it is a directory, ignores

			case "$(file --mime-type -b "$file")" in
				image/*)
					mv "$file" -t "$images_dir"
					echo "$file moved to $images_dir"
				;;

				text/*)
					mv "$file" -t "$texts_dir"
					echo "$file moved to $texts_dir"
				;;

				audio/*)
					mv "$file" -t "$audio_dir"
					echo "$file moved to $audio_dir"
				;;

				application/*)
					mv "$file" -t "$binaries_dir"
					echo "$file moved to $binaries_dir"
				;;

				video/*)
					mv "$file" -t "$videos_dir"
					echo "$file moved to $videos_dir"
				;;

				*)
					mv "$file" -t "$special_dir"
					echo "$file moved to $special_dir"
				;;
			esac
		done
	}


count_of_scans='1'
while true; do
	 rename "s/ /_/g" "$download_dir/*.*" # rename every file to avoid conflits with white space
	organize_files "$download_dir"
	echo ""
	echo "Downloads scan number ${count_of_scans}"
	let count_of_scans++	
	sleep 600 # scans the download directory each 10 minutes
done
