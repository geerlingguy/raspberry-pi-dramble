#!/bin/bash

# Raspberry Pi USB drive benchmark script.
#
# A script I use to automate the running and reporting of benchmarks I compile
# for: http://www.pidramble.com/wiki/benchmarks/external-usb-benchmarks
#
# Usage:
#   # Run it locally.
#   $ sudo ./usb-benchmarks.sh
#
#   # Run it straight from GitHub.
#   $ curl https://raw.githubusercontent.com/geerlingguy/raspberry-pi-dramble/master/setup/benchmarks/usb-benchmarks.sh | sudo bash
#
# Author: Jeff Geerling, 2020

printf "\n"
printf "Raspberry Pi Dramble USB drive benchmarks\n"

# Fail if $SUDO_USER is empty.
if [ -z "$SUDO_USER" ]; then
  printf "This script must be run with sudo.\n"
  exit 1;
fi

# TODO - Someday make it so a user can pick from a list of detected drives.
# Scan with one of the two commands below:
#   for devlink in /dev/disk/by-id/usb*; do readlink -f ${devlink}; done
#   ls -l /dev/disk/by-id/usb*
USB_DEVICE=/dev/sdb
# Make sure the drive is formatted (e.g. ext4) and mounted somewhere.
USB_DEVICE_MOUNT_PATH=/arcanite

# Variables.
USER_HOME_PATH=$(getent passwd $SUDO_USER | cut -d: -f6)
IOZONE_INSTALL_PATH=$USER_HOME_PATH
IOZONE_VERSION=iozone3_489

cd $IOZONE_INSTALL_PATH

# Install dependencies.
if [ ! `which hdparm` ]; then
  printf "Installing hdparm...\n"
  apt-get install -y hdparm
  printf "Install complete!\n\n"
fi
if [ ! `which curl` ]; then
  printf "Installing curl...\n"
  apt-get install -y curl
  printf "Install complete!\n\n"
fi
if [ ! `which make` ]; then
  printf "Installing build tools...\n"
  apt-get install -y build-essential
  printf "Install complete!\n\n"
fi

# Download and build iozone.
if [ ! -f $IOZONE_INSTALL_PATH/$IOZONE_VERSION/src/current/iozone ]; then
  printf "Installing iozone...\n"
  curl "http://www.iozone.org/src/current/$IOZONE_VERSION.tar" | tar -x
  cd $IOZONE_VERSION/src/current
  make --quiet linux-arm
  printf "Install complete!\n\n"
else
  cd $IOZONE_VERSION/src/current
fi

# Run benchmarks.
printf "Running hdparm test...\n"
hdparm -t $USB_DEVICE
printf "\n"

printf "Running dd test...\n\n"
dd if=/dev/zero of=${USB_DEVICE_MOUNT_PATH}/test bs=8k count=50k conv=fsync; rm -f ${USB_DEVICE_MOUNT_PATH}/test
printf "\n"

printf "Running iozone test...\n"
./iozone -e -I -a -s 100M -r 4k -i 0 -i 1 -i 2 -f ${USB_DEVICE_MOUNT_PATH}/iozone
printf "\n"

printf "USB drive benchmark complete!\n\n"
