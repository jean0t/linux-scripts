#!/usr/bin/env sh

#========================================================| HEADER
# Author: Jean0t
#
# Purpose: Using AI model through ollama without
#          the <think> section
#
#========================================================|


#========================================================| START
MODEL='$(ollama list | tail -n 1 | tr -s " " | cut -d " " -f 1)'

while true
do
    printf "%s" "> "
    read PROMPT
    if [ "$PROMPT" = "exit" ] || ["$PROMPT" = "q"]
    then
	break
    fi
    response=$(ollama run "$MODEL" "$PROMPT")
    response=$(echo $response | sed 's/<think>.*<\/think> //')
    printf "\n%s\n\n" "$response"
done
#========================================================|
