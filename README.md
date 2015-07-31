# Raspberry Pi Dramble

A cluster ([Bramble](http://elinux.org/Bramble)) of Raspberry Pis on which Drupal will be deployed using Ansible.

<p align="center"><img src="https://raw.githubusercontent.com/geerlingguy/raspberry-pi-dramble/master/images/raspberry-pi-dramble-hero.jpg" alt="Raspberry Pi Dramble - Hero Image" /></p>

Read the rest of this README and the official [Dramble Wiki](https://github.com/geerlingguy/raspberry-pi-dramble/wiki) for more information about the Dramble.

## Why

I'm doing presentations on Ansible, and how easy it makes infrastructure configuration, even for high-performance/high-availability Drupal sites. WiFi/Internet access is spotty at most conferences, so deploying to AWS, DigitalOcean, or other live public cloud instances that require a stable Internet connection is a Bad Idea™.

Deploying to VMs on my own presentation laptop is an option (and I've done this in the past), but it's not quite as impactful as deploying to real, live, 'in-the-flesh' servers. Especially if you can say you're carrying around a datacenter in your bag!

A cluster of servers, in my hand, at the presentation. With blinking LEDs!

## Official Site

You can browse more information about _geerlingguy_'s Dramble on [http://www.pidramble.com/](http://www.pidramble.com/). This website is actually running on the Rasbperry Pi Dramble cluster pictured above!

## Specs

  - 24 ARMv7 CPU Cores
  - 5.4 GHz combined compute power
  - 6 GB RAM
  - 96 GB microSD flash-based storage
  - 1 Gbps private network

## Getting the Pis (and other accessories)

Many people have asked for a basic list of components used in constructing the Dramble, or where I found particular parts. In the Wiki, I've added pages listing the following:

  - [Raspberry Pis and Accessories](https://github.com/geerlingguy/raspberry-pi-dramble/wiki/Raspberry-Pis-and-Accessories)
  - [Other Necessities](https://github.com/geerlingguy/raspberry-pi-dramble/wiki/Other-Necessities)
  - [Recommended Extras](https://github.com/geerlingguy/raspberry-pi-dramble/wiki/Recommended-Extras)

## Setting up the Pis

The process for setting up all the Raspberry Pis is outlined in the Wiki:

  1. [Create a base Raspbian image and clone it to all the microSD cards](https://github.com/geerlingguy/raspberry-pi-dramble/wiki/Build-Diet-Raspbian-Image)
  2. [Prepare the Raspberry Pis for provisioning](https://github.com/geerlingguy/raspberry-pi-dramble/wiki/Prepare-the-Raspberry-Pis)
  3. [Rack the Raspberry Pis](https://github.com/geerlingguy/raspberry-pi-dramble/wiki/Rack-the-Raspberry-Pis)
  4. [Network the Raspberry Pis](https://github.com/geerlingguy/raspberry-pi-dramble/wiki/Network-the-Raspberry-Pis)
  5. [Test the Ansible configuration](https://github.com/geerlingguy/raspberry-pi-dramble/wiki/Test-Ansible-configuration)
  6. [Provision the Raspberry Pis with `main.yml`](https://github.com/geerlingguy/raspberry-pi-dramble/wiki/Provision-the-Raspberry-Pis)
  7. [Deploy Drupal to the Raspberry Pis](https://github.com/geerlingguy/raspberry-pi-dramble/wiki/Deploy-Drupal-to-the-Raspberry-Pis)

### Benchmarks - Testing the performance of the Dramble

See the 'Benchmarks' section of the [Dramble Wiki](https://github.com/geerlingguy/raspberry-pi-dramble/wiki/Home) for current benchmarks and statistics.

## Drupal on a Single Pi - Drupal Pi

If you have only a single Raspberry Pi (model 2 recommended, otherwise Drupal will run _really_ slow), you can use the [Drupal Pi](https://github.com/geerlingguy/drupal-pi) project to quickly get Drupal running on the single Pi.

## Author

This project was started in 2015 by [Jeff Geerling](http://jeffgeerling.com/), author of [Ansible for DevOps](http://ansiblefordevops.com/).

Raspberry Pi image used in architecture diagram by [Multicherry](http://commons.wikimedia.org/wiki/User:Multicherry), downloaded from [Wikipedia](http://en.m.wikipedia.org/wiki/File:Raspberry_Pi_2_Model_B_v1.1_top_new_(bg_cut_out).jpg). All other logos are copyright their respective owners.
