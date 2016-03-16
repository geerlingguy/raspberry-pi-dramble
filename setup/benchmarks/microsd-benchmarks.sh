#!/bin/bash

# Raspberry Pi microSD card benchmark script.
#
# Just a little script I use to automate the running and reporting of benchmarks
# I compile on this page: http://www.pidramble.com/wiki/benchmarks/microsd-cards
#
# Usage:
#   # Run it locally.
#   $ sudo ./microsd-benchmarks.sh
#
#   # Run it straight from GitHub.
#   $ curl https://raw.githubusercontent.com/geerlingguy/raspberry-pi-dramble/\
#     master/setup/benchmarks/microsd-benchmarks.sh | sudo bash
#
# Author: Jeff Geerling, 2016

# Variables.
IOZONE_INSTALL_PATH=/home/pi
IOZONE_VERSION=iozone3_434

cd $INSTALL_PATH

# Install apt dependencies.
apt-get install -y hdparm curl

# Download and build iozone.
curl "http://www.iozone.org/src/current/$IOZONE_VERSION.tar" | tar -x
cd $IOZONE_VERSION/src/current
make --quiet linux-arm

# Run benchmarks.
hdparm -t /dev/mmcblk0
dd if=/dev/zero of=/home/pi/test bs=8k count=50k conv=fsync; rm -f /home/pi/test
./iozone -e -I -a -s 100M -r 4k -i 0 -i 1 -i 2