#!/usr/bin/env bash

################################################################################################### HEADER
#
# Author: Joao Mauricio (Jean0t)
# License: GPL-3
#
# Purpose: Configure the firewall automatically to create safe environments easily
#
###################################################################################################

################################################################################################### VERIFICATIONS
[ $UID -eq 0 ] || { echo 'you must be root to configure the firewall.' ; exit 1 ; }

$(command -v ufw 1>/dev/null 2>&1) || { echo 'you must have ufw installed in your system.' ; exit 1 ; } 

###################################################################################################



################################################################################################### START
# enables ufw service if it isn't running yet
systemctl is-active --quiet ufw || ufw enable  && systemctl enable ufw

# First configuration is to Deny every Incoming and Outcoming
# isolating the computer from the network
(ufw status verbose | grep -q "deny (incoming)") || ufw default deny incoming
(ufw status verbose | grep -q "deny (outgoing)") || ufw default deny outcoming

# Now we will set up rules and allowing ports one by one
# The internet conection ports will be set up automatically 
# due to the importance of it to everyone
(ufw status verbose | grep -qw 53)    || ufw allow out dns
(ufw status verbose | grep -qw 80)    || ufw allow out http
(ufw status verbose | grep -qw 443)   || ufw allow out https
(ufw status verbose | grep -qw 5353)  || ufw allow out mdns

# Now we will confirm the rules before advancing to other options
# usually that will be the basic and needed for most
ufw reload 1>/dev/null

printf "%s "  "The firewall is active and your network is secure. Do you want to allow custom services? [y/N] " 
read confirmation
[ "$confirmation" = "y" -o "$confirmation" = "Y" ] || { echo "Configuration completed." ; exit 0 ; }
# Choose the services that the user wants
PS3='Select a Service> '
select SERVICE in qBittorrent ssh smtp imap pop3 nfs www xmpp telnet exit; do
  case $REPLY in
    1)
      ufw allow qBittorrent
    ;;

    2)
      ufw allow ssh
    ;;

    3)
      ufw allow smtp
    ;;

    4)
      ufw allow imap
    ;;

    5)
      ufw allow pop3
    ;;

    6)
      ufw allow nfs
    ;;
    
    7)
      ufw allow www
    ;;

    8)
      ufw allow xmpp
    ;;

    9)
      ufw allow telnet
    ;;

    10)
      exit
    ;;
done
