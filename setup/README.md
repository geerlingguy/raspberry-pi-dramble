# Setup Files for Dramble

This directory contains some setup and cleanup-related playbooks and other files, meant to help with the general setup and configuration of Raspbian, Raspberry Pi hardware settings, the SD card, external storage, etc.

## Subdirectories

### diet-raspbian

The `diet-raspbian` project aims to trim the fat of the default Raspbian image. I've looked into using other people's minimal Raspbian images, but they're usually out of date by days, weeks, or months, and they aren't built in an open/simple way.

Therefore `diet-raspbian` uses Ansible to take a system built with the official Raspbian image, and strip it of extraneous bits like default IDEs, languages, Wolfram, a window manager, etc.
