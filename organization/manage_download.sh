#!/bin/bash

# This script scans your downloads directory to see if there is any new file
# if there is, it will move to the correspondent directory, be it audios, videos or anything else


#Directories
download_dir="$HOME/Downloads"
images_dir="$download_dir/images"
texts_dir="$download_dir/texts"
binaries_dir="$download_dir/binaries"
audio_dir="$download_dir/audio"
videos_dir="$download_dir/videos"


# creates the directories if they don't exist
if [ ! -d $images_dir ]; then
	mkdir "$images_dir" "$texts_dir" "$binaries_dir" "$audio_dir"
fi

#mkdir -p images_dir texts_dir binaries_dir audio_dir


organize_files() {

	for file in $(find "$download_dir" -maxdepth 1 -type f); do
			case "$(file --mime-type -b "$file")" in
				image/*)
					mv "$file" "$images_dir/"
					;;
				text/*|application/pdf)
					mv "$file" "$texts_dir/"
					;;
				audio/*)
					mv "$file" "$audio_dir/"
					;;
				application/*)
					mv "$file" "$binaries_dir/"
					;;
				video/*)
					mv "$file" "$videos_dir/"
					;;
			esac
		done
	}


count_of_scans=1
while true; do
	organize_files "$download_dir"
	echo "Downloads scan number ${count_of_scans} "
	((count_of_scans++))	
	sleep 600 # scans the download directory each 10 minutes
done
