# Raspberry Pi Dramble

A cluster ([Bramble](http://elinux.org/Bramble)) of 5 Raspberry Pis on which Drupal will be deployed using Ansible.

## Why

I'm doing presentations on Ansible, and how easy it makes infrastructure configuration, even for high-performance/high-availability Drupal sites. WiFi/Internet access is spotty at most conferences, so deploying to AWS, DigitalOcean, or other live public cloud instances is a Bad Idea™.

Deploying to VMs on my own presentation laptop is an option (and I've done this in the past), but it's not quite as impactful as deploying to real, live, 'in-the-flesh' servers.

Plus, it's cool. A server cluster, in my hand, at the presentation. With blinking lights and everything!

## Getting the Pis (and other accessories)

For the Dramble, I purchased the following:

  - 5x Raspberry Pi 2 Model B
  - 1x [50W 6-port USB desktop charger](http://www.amazon.com/gp/product/B00KHP6UVQ/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B00KHP6UVQ&linkCode=as2&tag=httpwwwmidw06-20&linkId=YEKQEOUTP3WTLSJJ) (to provide juice to the Pis)
  - 1x [6-pack micro USB cables](http://www.amazon.com/gp/product/B00N8VHW72/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B00N8VHW72&linkCode=as2&tag=httpwwwmidw06-20&linkId=63VSGWYRPJFO4IZO) (plugs from charger to Pis - cheap in bulk!)
  - 1x [5-pack 8GB microSD cards](http://www.amazon.com/gp/product/B00KI16OOW/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B00KI16OOW&linkCode=as2&tag=httpwwwmidw06-20&linkId=JM2T4CPMOOJA44AW) (one for each Pi, cheap in bulk!)
  - 1x [8-port unmanaged Gigabit network switch](http://www.amazon.com/gp/product/B001QUA6RA/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B001QUA6RA&linkCode=as2&tag=httpwwwmidw06-20&linkId=24SPP5YZJR6KK7GH) (for inter-Pi networking)
  - CASE

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

Download Raspbian from the [Raspberry Pi Operating System Images](http://www.raspberrypi.org/downloads/) page, and expand the .zip file after it's finished downloading. This should result in a `.img` file that you'll copy to all your microSD cards.

Then (assuming you're using a Mac), insert the microSD card into your card reader, then open up Terminal and enter the following commands.

    # Get a list of all connected disks.
    $ diskutil list

    # Unmount the microSD card (get the path from the `list` command above).
    $ diskutil unmountDisk /dev/disk3

    # Copy the image to the microSD card (this will take 10+ minutes).
    $ sudo dd bs=1m if=/path/to/2015-01-31-raspbian.img of=/dev/disk3

The last command copies the Raspbian disk image, byte-for-byte, to the microSD card. Generally, this takes 10-20 minutes for a typical Class 10 microSD card. Timing will vary based on how fast/slow your card is for writes.

> Note that copying the image will only fill the microSD card as much as the original raspbian image. Once you boot a Pi with the card the first time, you can use the `raspi-config` utility on the Pi to expand the partition to fill up the card's remaining space.

### Preparing the Raspberry Pis

TODO.

### Racking the Raspberry Pis

TODO.

### Provisioning the Raspberry Pis

TODO.

### Deploying Drupal to the Raspberry Pis

TODO.

## Author

This project was started in 2015 by [Jeff Geerling](http://jeffgeerling.com/), author of [Ansible for DevOps](http://ansiblefordevops.com/).
