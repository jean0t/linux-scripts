#!/usr/bin/env bash

[[ $( ping -c1 8.8.8.8 >&- 2>&1 ) ]] || { echo 'You do not have a network connection.' ; exit 1 ; }
[[ -n "$1" ]] || { echo 'You must pass a URL' ; exit 1 ; }

case "$1" in
	-h|--help) { echo -e "Send a URL after call the program to be analyzed\nExample:\tsiteWasUpdated google.com" ; exit 0 ; } ;;
 	*) { echo "This command isn't recognized" ; exit 1 ; } ;;
esac

read -p "Website: " $1 # takes the website from the command
OLD_CHECKSUM=$(curl -s "$URL" | md5sum | cut -d ' ' -f1)

check_site() {
	NEW_CHECKSUM=$(curl -s "$1" | md5sum | cut -d ' ' -f1)

	if [ "$2" != "$NEW_CHECKSUM" ]; then
		notify-send "Website was updated"
	else
		echo "No updates yet"
	fi
}

# loop to check the website regularly
while true; do
	check_site $URL $OLD_CHECKSUM
	sleep 300 # waits for 5 minutes to check if the website was updated 
done
