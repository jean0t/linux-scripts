#!/bin/bash

read -p "Website: " URL
OLD_CHECKSUM=$(curl -s "$URL" | md5sum | cut -d ' ' -f1)

check_site() {
	NEW_CHECKSUM=$(curl -s "$1" | md5sum | cut -d ' ' -f1)

	if [ "$2" != "$NEW_CHECKSUM" ]; then
		notify-send "Website was updated"
	else
		echo "No updates yet"
	fi
}


while true; do
	check_site $URL $OLD_CHECKSUM
	sleep 100
done
