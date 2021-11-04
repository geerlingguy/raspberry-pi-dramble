#!/bin/bash

# Raspberry Pi HDD/SDD benchmark script.
#
# A script I use to automate the running and reporting of benchmarks I compile
# for: http://www.pidramble.com/wiki/benchmarks
#
# Usage:
#   # Run it locally (overriding device and mount path).
#   $ sudo DEVICE_UNDER_TEST=/dev/sda1 DEVICE_MOUNT_PATH=/mnt/sda1 ./disk-benchmark.sh
#
#   # Run it straight from GitHub (with default options).
#   $ curl https://raw.githubusercontent.com/geerlingguy/raspberry-pi-dramble/master/setup/benchmarks/disk-benchmark.sh | sudo bash
#
# Author: Jeff Geerling, 2021

printf "\n"
printf "Raspberry Pi disk benchmarks\n"

# Fail if $SUDO_USER is empty.
if [ -z "$SUDO_USER" ]; then
  printf "This script must be run with sudo.\n"
  exit 1;
fi

# Variables.
DEVICE_UNDER_TEST=${DEVICE_UNDER_TEST:-"/dev/sda1"}
DEVICE_MOUNT_PATH=${DEVICE_MOUNT_PATH:-"/mnt/sda1"}
USER_HOME_PATH=$(getent passwd $SUDO_USER | cut -d: -f6)
IOZONE_INSTALL_PATH=$USER_HOME_PATH
IOZONE_VERSION=iozone3_492

cd $IOZONE_INSTALL_PATH

# Install dependencies.
if [ ! `which fio` ]; then
  printf "Installing fio...\n"
  apt-get install -y fio
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
printf "Running fio sequential read test...\n"
fio \
  --filename=$DEVICE_UNDER_TEST \
  --direct=1 \
  --rw=read \
  --bs=1024k \
  --ioengine=libaio \
  --iodepth=64 \
  --size=4G \
  --runtime=10 \
  --numjobs=4 \
  --group_reporting \
  --name=fio-rand-read-sequential \
  --eta-newline=1 \
  --readonly
printf "\n"

# This test is destructive to a mounted volume.
# printf "Running fio sequential write test...\n"
# fio \
#   --filename=$DEVICE_UNDER_TEST \
#   --sync=0 \
#   --do_verify=0 \
#   --direct=1 \
#   --rw=write \
#   --allow_mounted_write=1 \
#   --bs=1024k \
#   --ioengine=libaio \
#   --iodepth=64 \
#   --size=4G \
#   --runtime=10 \
#   --numjobs=4 \
#   --group_reporting \
#   --name=fio-rand-read-sequential \
#   --eta-newline=1
# printf "\n"

printf "Running iozone 1024K random read and write tests...\n"
./iozone -e -I -a -s 100M -r 1024k -i 0 -i 2 -f $DEVICE_MOUNT_PATH/iozone
printf "\n"

printf "Running iozone 4K random read and write tests...\n"
./iozone -e -I -a -s 100M -r 4k -i 0 -i 2 -f $DEVICE_MOUNT_PATH/iozone
printf "\n"

printf "Disk benchmark complete!\n\n"
