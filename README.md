# Raspberry Pi Dramble

A cluster ([Bramble](http://elinux.org/Bramble)) of 5 Raspberry Pis on which Drupal will be deployed using Ansible.

## Why

I'm doing presentations on Ansible, and how easy it makes infrastructure configuration, even for high-performance/high-availability Drupal sites. WiFi/Internet access is spotty at most conferences, so deploying to AWS, DigitalOcean, or other live public cloud instances that require a stable Internet connection is a Bad Idea™.

Deploying to VMs on my own presentation laptop is an option (and I've done this in the past), but it's not quite as impactful as deploying to real, live, 'in-the-flesh' servers. Especially if you can say you're carrying around a datacenter in your bag!

A cluster of servers, in my hand, at the presentation. With blinking LEDs!

## Specs

  - 20 ARMv7 CPU Cores
  - 4.5 GHz combined compute power
  - 5 GB RAM
  - 80 GB microSD-based storage
  - 64 GB SSD-based storage
  - 1 Gbps network with mixed 10/100 and Gigabit connectivity

As you can see from the above specs; it takes 5+ Raspberry Pis to equal the capacity of one moderate workstation nowadays. Raspberry Pis are not the most economical or power-saving way to build Drupal infrastructure, but they are great for educational purposes, and it's a fun project to build 'bare metal' infrastructure with your own hands!

## Getting the Pis (and other accessories)

For the Dramble, I purchased the following:

  - 5x Raspberry Pi 2 Model B
  - 1x [50W 6-port USB desktop charger](http://www.amazon.com/gp/product/B00KHP6UVQ/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B00KHP6UVQ&linkCode=as2&tag=httpwwwmidw06-20&linkId=YEKQEOUTP3WTLSJJ) (to provide juice to the Pis)
  - 1x [6-pack micro USB cables](http://www.amazon.com/gp/product/B00N8VHW72/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B00N8VHW72&linkCode=as2&tag=httpwwwmidw06-20&linkId=63VSGWYRPJFO4IZO) (plugs from charger to Pis - cheap in bulk!)
  - 1x [5-pack 8GB microSD cards](http://www.amazon.com/gp/product/B00KI16OOW/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B00KI16OOW&linkCode=as2&tag=httpwwwmidw06-20&linkId=JM2T4CPMOOJA44AW) (one for each Pi, cheap in bulk!)
  - 1x [8-port unmanaged Gigabit network switch](http://www.amazon.com/gp/product/B001QUA6RA/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B001QUA6RA&linkCode=as2&tag=httpwwwmidw06-20&linkId=24SPP5YZJR6KK7GH) (for inter-Pi networking)
  - 1x [Raspberry Pi B+ Stackable Case Triplestack](http://www.ebay.com/itm/271648357906)
  - 2x [Raspberry Pi B+ Case, Stackable - Additional Level](http://www.ebay.com/itm/271614825269)

Other necessities, which I already had on-hand (but you might need to purchase):

  - Cat 5e or Cat 6 network cable for making patch cords. (I have hundreds of feet of the stuff, and can quickly punch down a patch cable, so I just made my own).
  - A power outlet.
  - A computer to run the Ansible playbooks (you can do it all on the Pis themselves, but I prefer working on my Mac workstation and leaving all the Pis headless).

Other accessories, optional but helpful for general Pi development:

  - [802.11b/g/n USB WiFi adapter](http://www.amazon.com/gp/product/B003MTTJOY/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B003MTTJOY&linkCode=as2&tag=httpwwwmidw06-20&linkId=WCTEZWNBLNNQ35E5) (I have a few; handy for getting online away from wired jack)
  - [5mm Diffused RGB LEDs](http://www.amazon.com/gp/product/B006S21SAK/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B006S21SAK&linkCode=as2&tag=httpwwwmidw06-20&linkId=2D7X6HRTJFTESGT2) (great for showing status!)
  - [Assembled RPi GPIO Cobbler with 40-pin cable](http://www.amazon.com/gp/product/B00Q1T07O8/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B00Q1T07O8&linkCode=as2&tag=httpwwwmidw06-20&linkId=JG3OGOMBG75D6BFY) (helpful for prototyping)
  - Half-size breadboard
  - Breadboard/prototyping jumper cables

## Setting up the Pis

### Preparing the microSD cards (with Raspbian)

Download Raspbian from the [Raspberry Pi Operating System Images](http://www.raspberrypi.org/downloads/) page, and expand the .zip file after it's finished downloading.

You could copy this image file to each of your microSD cards directly using `diskutil unmountDisk /dev/diskX` and `sudo dd bs=1m if=/path/to/2015-01-31-raspbian.img of=/dev/diskX` (where `X` is the number for the microSD card on your Mac - found with `diskutil list`), however, I recommend using [`diet-raspbian`](https://github.com/geerlingguy/diet-raspbian) to build a minimal image based off Raspbian.

[`diet-raspbian`](https://github.com/geerlingguy/diet-raspbian) is included as a git submodule inside the `setup` folder, but you should read the instructions included in that project's [README](https://github.com/geerlingguy/diet-raspbian/blob/master/README.md).

The basic process is as follows:

  1. Clone the official Raspbian image to a microSD card and boot a Pi with it.
  2. Trim the fat from the distribution using the included `diet.yml` Ansible playbook.
  3. Resize the partition to a much smaller size (from ~3GB to ~1.25GB).
  4. Clone the new, minified Raspbian image to your Mac.
  5. Copy this new, minified image to all your microSD cards.

`diet-raspbian`'s instructions are very thorough and it should work with the latest build of Raspbian.

### Preparing the Raspberry Pis

Assuming you've cloned a `diet-raspbian`-based image, you shouldn't need to configure the Pis directly (via terminal session with a connected display/keyboard). However, if you use the default Raspbian image, and still need to perform the initial configuration steps (e.g. `raspi-config`), you can still do so headless via SSH:

  1. Find the Raspberry Pi's IP address, and connect via SSH: `ssh pi@[IP-ADDRESS]`
  2. Default username is `pi` and default password is `raspberry`.
  3. Once logged in, run `sudo raspi-config`, and follow the prompts.

Even if you *did* use the `diet-raspbian` image, you may wish to expand the filesystem to fill the entire microSD card on each Pi using the first option in `sudo raspi-config`. You could set hostnames at this point, too, but we'll do that as part of the automated provisioning.

### Racking the Raspberry Pis

  1. Mount one Pi per tier of the stackable case.
  2. Mount the stack to a board, and mount the network switch and USB power supply as well.
  3. Plug each Pi into one of the power supply's jacks, ensuring any Pis that will be powering extra USB devices (e.g. the database server) is plugged into a 2A port.
  4. Create custom-sized Cat 5e/Cat 6 cables, one-per-Pi, to connect to the network switch.
  5. Run power to the switch and to the USB power supply.
  6. Profit!

### Provisioning the Raspberry Pis

Once all the Pis are booted, and you are able to log into them over the network via SSH, we'll run the `provision.yml` playbook to provision them (installing the appropriate software packages to run Drupal).

TODO.

### Deploying Drupal to the Raspberry Pis

After all the Raspberry Pis are provisioned, it's time to deploy our brand new Drupal 8 site to them!

TODO.

## Author

This project was started in 2015 by [Jeff Geerling](http://jeffgeerling.com/), author of [Ansible for DevOps](http://ansiblefordevops.com/).
