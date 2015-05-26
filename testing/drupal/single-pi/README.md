# Drupal on a Single Raspberry Pi

For those who only have one Raspberry Pi available, many of the lessons learned when running Drupal on a cluster of Raspberry Pis can still apply, just on a smaller scale.

This playbook/project makes setting up Drupal on a single Raspberry Pi a very easy/simple operation.

## Set up the Raspberry Pi

Drupal requires as good a Raspberry Pi as you can afford. While Drupal will run okay on any Raspberry Pi, it's best to use a B+/A+ (which has a single core processor and 512MB RAM) or B model 2 (which has a four-core processor and 1GB RAM).

Once you have your Raspberry Pi and a good microSD card (the fastest/best one you can get!), you will need to do a few things to set up the Raspberry Pi and get it ready to run the Drupal installation playbook:

  1. Download the latest 'Raspbian' image from the [Raspberry Pi Downloads page](https://www.raspberrypi.org/downloads/).
  2. Follow the [image installation guide](https://www.raspberrypi.org/documentation/installation/installing-images/README.md) to transfer the image to your microSD card.
  3. Once Raspbian is loaded on the card, insert the card in your Pi, and plug in your Pi to boot it up.
  4. **If you don't have a monitor attached to the Pi**: TODO.
  5. **If you have a monitor attached to the Pi**:
    1. Boot up the Raspberry Pi. It will automatically launch the `raspi-config` tool to configure some important settings.
    2. Select the 'Expand filesystem' option and confirm.
    3. Select the 'Change User Password' option and enter a secure password for the `pi` account.
    4. Select the 'Localization options' option and set your language, timezone, and keyboard settings.
    5. Select the 'Advanced options' option and choose a good hostname (e.g. `my-pi`), and also set the 'memory split' to `16` MB, unless you're going to use the Pi with a GUI and need the video memory.
    6. Select the 'Finished' option to reboot the Pi.
  6. **If you have a wireless network adapter you need to set up**: Please see this guide: [Setting up a WiFi Adapter on a Raspberry Pi](http://www.midwesternmac.com/blogs/jeff-geerling/edimax-ew-7811un-tenda-w311mi-wifi-raspberry-pi)
  7. Install Ansible:
    1. Update the local apt cache: `sudo apt-get update`
    2. Install pip and Python dev tools: `sudo apt-get install -y python-dev python-pip`
    3. Install Ansible: `sudo pip install ansible`
  8. Test the Ansible installation: `ansible --version` (should output the Ansible version).

## Install LEMP software stack and Drupal

Now that the Raspberry Pi is set up and ready to go, you need to download this repository to the Pi, then run the included playbook to install and configure everything.

  1. Download the `raspberry-pi-dramble` project: `wget https://github.com/geerlingguy/raspberry-pi-dramble/archive/master.zip`
  2. Unzip the project: `unzip master.zip`
  3. cd into this directory: `cd raspberry-pi-dramble-master/testing/drupal/single-pi/`
  4. Install required Ansible roles: `sudo ansible-galaxy install -r requirements.txt`
  4. Run the Ansible playbook: `ansible-playbook -i inventory setup.yml`

After a few minutes, the playbook should complete successfully, and you should have Drupal running on your Raspberry Pi, accessible via `http://pidramble.com/` (make sure you [add an entry to your local hosts file](http://www.rackspace.com/knowledge_center/article/how-do-i-modify-my-hosts-file) for the Pi's address, e.g. `[PI_IP_ADDRESS]  pidramble.com`).

If you want to change the version of the project installed, you can change `drupal_version` in `vars.yml`. As an example, if it's currently set to `1.2.0`, you can change it to `1.2.1`, which will update the checked out repository, and then run database updates, a config import, and a cache rebuild.
