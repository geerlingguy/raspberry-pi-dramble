#!/bin/bash

#
# Simple helper script to get IP addresses from a Mac Address
# This needs to use arp-scan because of the differences in the `arp` command output on Linux/MacOS
#

# Install arp-can
#   Linux: sudo apt-get install arp-scan
#   MacOS: brew install arp-scan

# Replace Mac Addresses below with yours
mac_addresses=(dc:a6:32:00:81:c6 dc:a6:32:05:1a:09 dc:a6:32:05:32:72)

for mac_address in "${mac_addresses[@]}"  
do
    ip=$(sudo arp-scan -l | grep "${mac_address}" | awk '{print $1}')
    echo "mac address ${mac_address} is a registered to ip ${ip}"
done