#!/usr/bin/env sh

#=====================================================| HEADER
#   Author: Joao Mauricio (Jean0t)
#   github.com/jean0t
#
#   purpose: quick way to access hacker news
#            from the terminal
#=====================================================|


#=====================================================| CHANGELOG
#   
#   1.0:
#       Script created
#
#
#   1.2:
#       fix: crontab is now functional
#
#
#=====================================================|


#=====================================================| GLOBAL VARIABLES

VERSION='1.1'

WEBSITE="https://news.ycombinator.com/"

TEMPFILE="/tmp/hacker_news.cache"

CRONJOB="*/5 * * * *" # it will update each 5 minutes

CACHE_TIME=300 # 5 minutes

HELP='USAGE:
    ./hacker_news_cli.sh [options]

OPTIONS:
    -v|--version
        See the current version of the script

    -r|--reload
        reload the cached content

    -c|--cronjob path/to/script
        set a cronjob to refresh the cache each 5 minutes

    -s|--show
        prints the content

    -h|--help
        open this help message
'

#=====================================================|


#=====================================================| VERIFICATIONS

# Json parser
command -v jq 1>/dev/null 2>&1 || exit 1

# Curl used to fetch the html
command -v wget 1>/dev/null 2>&1 || exit 1

# Pup is used to parse the html
command -v pup 1>/dev/null 2>&1 || exit 1

#=====================================================|


#=====================================================| FUNCTIONS

time_passed() {
    TIME_MODIFICATION_FILE=$(stat -c %Y "$TEMPFILE" 2>/dev/null || echo 0)
    TIME_NOW=$(date "+%s")
    VARIATION_TIME=$((TIME_NOW - TIME_MODIFICATION_FILE))

    echo ${VARIATION_TIME:-301}
}


refresh_cache() {
    if [ ! -e "$TEMPFILE" ] || [ $(time_passed) -gt ${CACHE_TIME} ]
    then
        CONTENT=$(wget -qO- "$WEBSITE" | \
        pup 'table table tr:nth-last-of-type(n+2) td.title a json{}' | \
        jq '.[] | select(.text != null) | {text, href}' | \
        jq -r '"Title: \(.text)\nLink: \(.href)\n----\n"')

        echo "${CONTENT}\n\nLast Update:$(date '+%d/%m/%y - %H:%M')\n\n" > $TEMPFILE
    fi
}

error_msg() {
    printf "%s\n" "$1"
    exit 1
}

msg() {
    printf "%s\n" "$1"
}

#=====================================================|

#=====================================================| START

case "$1" in
    -v|--version)
        printf "%s\n" "Version $VERSION - 26.02.2025"
    ;;

    -c|--crontab)
        systemctl list-units --type=service | grep -q crond.service || error_msg "Cron is not running." 
        [ -z "$2" ] && error_msg "Provide a path."
        [ -e $(realpath "$2") ] || error_msg "Provide a valid path to the script."

        crontab -l 2>/dev/null | grep -qF "$CRONJOB $(realpath ${2}) -with -r" || echo "$(crontab -l)\n$CRONJOB $(realpath ${2}) -r" | crontab -
        msg "Cronjob added! Now your cache will keep refreshing each 5 minutes."

    ;;

    -s|--show)
        if [ -e "$TEMPFILE" ]
        then
            msg ""
            cat $TEMPFILE
        fi
    ;;
    
    -r|--reload)
        refresh_cache
    ;;

    -h|--help)
        msg "$HELP"
    ;;

esac

#=====================================================|
