<a href="http://www.pidramble.com"><img src="https://cdn.rawgit.com/geerlingguy/raspberry-pi-dramble/master/images/logo.svg" width="100%" height="73"></a>

# Raspberry Pi Dramble

[![Build Status](https://travis-ci.org/geerlingguy/raspberry-pi-dramble.svg?branch=master)](https://travis-ci.org/geerlingguy/raspberry-pi-dramble)

> **NOTE**: This project is currently being converted to use Kubernetes as the foundational layer of the Drupal site infrastructure. Please [check out the `kubernetes` branch](https://github.com/geerlingguy/raspberry-pi-dramble/tree/kubernetes) and see its README for more info.

A cluster ([Bramble](http://elinux.org/Bramble)) of Raspberry Pis on which Drupal will be deployed using Ansible.

<p align="center"><img src="https://raw.githubusercontent.com/geerlingguy/raspberry-pi-dramble/master/images/raspberry-pi-dramble-hero.jpg" alt="Raspberry Pi Dramble - Hero Image" /></p>

Read the rest of this README and the official [Dramble Wiki](http://www.pidramble.com/wiki) for more information about the Dramble.

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

  - [Raspberry Pis and Accessories](http://www.pidramble.com/wiki/hardware/pis)
  - [Other Necessities](http://www.pidramble.com/wiki/hardware/necessities)
  - [Recommended Extras](http://www.pidramble.com/wiki/hardware/extras)

## Setting up the Pis

The process for setting up all the Raspberry Pis is outlined in the Wiki:

  1. [Prepare the Raspberry Pis for provisioning](http://www.pidramble.com/wiki/setup/prepare)
  2. [Rack the Raspberry Pis](http://www.pidramble.com/wiki/setup/rack)
  3. [Network the Raspberry Pis](http://www.pidramble.com/wiki/setup/network)
  4. [Test the Ansible configuration](http://www.pidramble.com/wiki/setup/test-ansible)
  5. [Provision the Raspberry Pis](http://www.pidramble.com/wiki/setup/provision)
    - TODO: This documentation needs updating for Kubernetes.
  6. [Deploy Drupal to the Raspberry Pis](http://www.pidramble.com/wiki/setup/deploy-drupal)
    - TODO: This documentation needs updating for Kubernetes.

### Kubernetes Setup Notes

Until the official Pi Dramble Wiki is updated (see TODOs above), this section of the README should suffice for setup steps for someone familiar with command line usage.

  1. Run the main playbook to install Kubernetes on all the Pis and configure the cluster:

         ansible-playbook -i inventory main.yml

  2. You can SSH into the Kubernetes master (10.0.100.61 by default) and run `kubectl` by switching to the root user (`sudo su`). For example:

         kubectl get nodes
         kubectl get pods
         ...

  3. Edit your `/etc/hosts` file and add the line:

         cluster.pidramble.test  10.0.100.62

  5. After that, you can access the `drupal8` Kubernetes service at the URL: `http://cluster.pidramble.test/`.

> Note that for the hosts file, you can point the domain at any of the non-master nodes (e.g. `10.0.100.62`, `10.0.100.63`, etc.); they are all running the Traefik ingress controller as a Kubernetes DaemonSet, meaning any single host can direct traffic on port 80 to the `drupal8` service. Technically, you could use DNS round robin to point one domain at all the Pis, but the best solution is to have another load balancer in front of all the Pis, redirecting the traffic to them using a more intelligent load balancing and health monitoring solution.

### Benchmarks - Testing the performance of the Dramble

See the [Pi Dramble Benchmarks](http://www.pidramble.com/wiki/benchmarks) section of the Wiki for current benchmarks and statistics.

## Local testing

A Vagrantfile is also included for local testing and debugging of the Kubernetes cluster and manifests using [Vagrant](https://www.vagrantup.com). See the [Vagrant README](testing/vagrant/README.md) for more details.

## Drupal on a Single Pi - Drupal Pi

If you have only a single Raspberry Pi, you can use the [Drupal Pi](https://github.com/geerlingguy/drupal-pi) project to quickly get Drupal running on the single Pi.

## Using older or slower Raspberry Pi models

The Raspberry Pi 2, 3, and 3 B+ have quad-core processors that make certain operations four to ten times faster than single-core Pis like the A+, B+, Zero, etc. Additionally, cluster members need as much RAM as possible, and any Pi without at least 1 GB of RAM is woefully underpowered for this setup.

Therefore only the following Pi models are officially supported at this time:

  - Raspberry Pi model 3 B+
  - Raspberry Pi model 3 B
  - Raspberry Pi model 2

## Author

This project was started in 2015 by [Jeff Geerling](https://www.jeffgeerling.com/), author of [Ansible for DevOps](https://www.ansiblefordevops.com/).
