#!/bin/bash

read -p 'How many minutes you want to work? ' TIME
MESSAGE="your period of work ended, take some time to rest"
AUDIO="" # put the path to the audio file you want
MINUTES=$(( TIME * 60 ))

wait_time () {
	sleep 1
}

play_audio () {
	aplay "$AUDIO" &> /dev/null
}

notify_end () {
	TITLE="Time-ended"
	MESSAGE="Take some time to rest, your work period ended"
	notify-send "$TITLE" "$MESSAGE"
}

work_time () {
	for seconds in $(seq 1 $MINUTES)
	do
		wait_time $seconds
		if [[ $(( seconds%60 )) -eq 0  ]]; then
			echo -en "$(( seconds/60 )) passed from $TIME\r"
		fi
	done
}

work_time && notify_end && [ -n "$AUDIO" ] && play_audio
