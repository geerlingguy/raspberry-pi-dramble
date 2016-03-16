#!/bin/bash

# Raspberry Pi microSD card benchmark script.
#
# A script I use to automate the running and reporting of benchmarks I compile
# for: http://www.pidramble.com/wiki/benchmarks/microsd-cards
#
# Usage:
#   # Run it locally.
#   $ sudo ./microsd-benchmarks.sh
#
#   # Run it straight from GitHub.
#   $ curl https://raw.githubusercontent.com/geerlingguy/raspberry-pi-dramble/master/setup/benchmarks/microsd-benchmarks.sh | sudo bash
#
# Author: Jeff Geerling, 2016

# Variables.
IOZONE_INSTALL_PATH=/home/pi
IOZONE_VERSION=iozone3_434

cd $IOZONE_INSTALL_PATH

# Install apt dependencies.
if [ ! `which hdparm` ]; then
  printf "Installing apt dependencies...\n"
  apt-get install -y hdparm curl
  printf "Install complete!\n\n"
fi

# Download and build iozone.
if [ ! -f $IOZONE_INSTALL_PATH/$IOZONE_VERSION/src/current/iozone ]; then
  printf "Installing iozone...\n"
  curl "http://www.iozone.org/src/current/$IOZONE_VERSION.tar" | tar -x
  cd $IOZONE_VERSION/src/current
  make --quiet linux-arm
  printf "Install complete!\n\n"
fi

# Run benchmarks.
printf "Running hdparm test...\n"
hdparm -t /dev/mmcblk0

printf "Running dd test...\n"
dd if=/dev/zero of=/home/pi/test bs=8k count=50k conv=fsync; rm -f /home/pi/test

printf "Running iozone test...\n"
./iozone -e -I -a -s 100M -r 4k -i 0 -i 1 -i 2

printf "microSD card benchmark complete!\n"
