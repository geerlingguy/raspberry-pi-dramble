# Setup Files for Dramble

This directory contains some setup and cleanup-related playbooks and other files, meant to help with the general setup and configuration of Raspbian, Raspberry Pi hardware settings, the SD card, external storage, etc.

## Subdirectories

### benchmarks

Benchmark data I've compiled while testing various aspects of many Raspberry Pis (usually stored in a proprietary `.numbers` format), with fancy graphs and such.

### gpio-led

The scripts and documentation inside `gpio-led` help configure the GPIO pins on a Raspberry Pi to control LEDs. In the Dramble's case, an RGB LED can be added to indicate status for deployments, startup, etc.

### networking

Set up Dramble networking by assigning a uniform set of IP addresses and hostnames based on Pi MAC addresses.
