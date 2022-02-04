#!/bin/bash

#cat /etc/openvpn/*.conf | grep "remote " | cut -d " " -f 2 | cut -d "." -f 1 | cut -d "-" -f 2-

# this will work if network manager is used for the VPN connection!
vpn=$(ps aux | grep "/usr/sbin/openvpn" | awk -F '--remote' '{print $2}' | cut -d " " -f 2)

if [[ $vpn == *"hackthebox"* ]]
then
    echo $vpn | cut -d "." -f 1 | cut -d "-" -f 2-
elif [ -n "$vpn" ]
then
    echo $vpn
else
    echo ""
fi
