<a href="http://www.pidramble.com"><img src="https://cdn.rawgit.com/geerlingguy/raspberry-pi-dramble/master/images/logo.svg" width="100%" height="73"></a>

# Raspberry Pi Dramble

[![Build Status](https://travis-ci.org/geerlingguy/raspberry-pi-dramble.svg?branch=master)](https://travis-ci.org/geerlingguy/raspberry-pi-dramble)

A cluster ([Bramble](http://elinux.org/Bramble)) of Raspberry Pis on which Drupal is deployed using Ansible and Kubernetes.

<p align="center"><img src="https://raw.githubusercontent.com/geerlingguy/raspberry-pi-dramble/master/images/raspberry-pi-dramble-hero-2019.jpg" alt="Raspberry Pi Dramble - Hero Image" /></p>

Read the rest of this README and the official [Pi Dramble Wiki](http://www.pidramble.com/wiki) for more information about the Dramble.

## Why

I'm doing presentations on Ansible, and how easy it makes infrastructure configuration, even for high-performance/high-availability Drupal sites. WiFi/Internet access is spotty at most conferences, so deploying to AWS, DigitalOcean, or other live public cloud instances that require a stable Internet connection is a Bad Idea™.

I'm also presenting on Kubernetes, and how easy it is to have self-healing, almost-infinitely-scalable infrastructure (managed with Ansible), and it's more fun to build with Kubernetes on bare metal... at least when the RAM on the Kubernetes master isn't all eaten up!

But really, it's just plain awesome. How many people can say they carry their entire datacenter in a travel bag, and can run it from a USB battery pack?

A cluster of servers, in my hand, at the presentation. With blinking LEDs!

## Official Site

You can browse more information about _geerlingguy_'s Dramble on [http://www.pidramble.com/](http://www.pidramble.com/). This website is actually running on the Rasbperry Pi Dramble cluster pictured above!

## Specs

  - 16+ ARMv7 CPU Cores
  - 5.6 GHz combined compute power
  - 4 GB RAM
  - 128 GB microSD flash-based storage
  - 1 Gbps private network with PoE

## Getting the Pis (and other accessories)

Many people have asked for a basic list of components used in constructing the Dramble, or where I found particular parts. In the Wiki, I've added pages listing the following:

  - [Raspberry Pis and Accessories](http://www.pidramble.com/wiki/hardware/pis)
  - [Other Necessities](http://www.pidramble.com/wiki/hardware/necessities)
  - [Recommended Extras](http://www.pidramble.com/wiki/hardware/extras)

## Setting up the Pis

The process for setting up all the Raspberry Pis is outlined in the Wiki:

  1. [Prepare the Raspberry Pis for provisioning](http://www.pidramble.com/wiki/setup/prepare)
  1. [Rack the Raspberry Pis](http://www.pidramble.com/wiki/setup/rack)
  1. [Network the Raspberry Pis](http://www.pidramble.com/wiki/setup/network)
  1. [Test the Ansible configuration](http://www.pidramble.com/wiki/setup/test-ansible)
  1. [Provision the Raspberry Pis](http://www.pidramble.com/wiki/setup/provision)
  1. [Deploy Drupal to the Raspberry Pis](http://www.pidramble.com/wiki/setup/deploy-drupal)

#### Adding more nodes

You can add more than four nodes, if you desire; add additional hosts in the same sequence in the following files:

  - `setup/networking/inventory`
  - `setup/networking/vars.yml`
  - `inventory`

If you need to change the IP subnet (default is `10.0.100.x`), make sure to also update `hosts.j2` to use the new subnet so hostnames resolve correctly.

#### Private Docker Registry Usage

The Pi Dramble includes a built-in Docker registry that is used to host Drupal images for deployment to Kubernetes. To use the Docker registry manually (to push or pull images):

  1. Edit your `/etc/hosts` file and add the line:

     ```
     10.0.100.62  registry.pidramble.test
     ```

  1. Follow the linked directions to [get Docker to use your self-signed Docker Registry cert](https://docs.docker.com/registry/insecure/#use-self-signed-certificates). For macOS, using the GUI:
    1. Double-click on `k8s-manifests/docker-registry/certs/tls.crt` to add it to your Keychain
    1. Select the certificate in Keychain Access, choose 'File' > 'Get Info'
    1. Expand the 'Trust' section, and choose 'Always Trust' for "When using this certificate:"
    1. Close the info dialog and enter your password to save the changes.
    1. Restart Docker for Mac.
  1. Tag your image for the registry and push it:

     ```
     docker tag my/image:latest registry.pidramble.test/my/image:latest
     docker push registry.pidramble.test/my/image:latest
     ```

## Benchmarks - Testing the performance of the Dramble

See the [Pi Dramble Benchmarks](http://www.pidramble.com/wiki/benchmarks) section of the Wiki for current benchmarks and statistics.

## Local testing

A Vagrantfile is also included for local testing and debugging of the Kubernetes cluster and manifests using [Vagrant](https://www.vagrantup.com). See the [Vagrant README](testing/vagrant/README.md) for more details.

## Drupal on a Single Pi - Drupal Pi

If you have only a single Raspberry Pi, you can use the [Drupal Pi](https://github.com/geerlingguy/drupal-pi) project to quickly get Drupal running on the single Pi.

## Using older or slower Raspberry Pi models

The Raspberry Pi 2, 3, 3 B+, and 4 have quad-core processors that make certain operations four to ten times faster than single-core Pis like the A+, B+, Zero, etc. Additionally, cluster members need as much RAM as possible, and any Pi without at least 1 GB of RAM simply [can't be used as a Kubernetes master](https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/memory-constraint-namespace/#before-you-begin).

Therefore only the following Pi models are officially supported:

  - Raspberry Pi model 4 B
  - Raspberry Pi model 3 B+
  - Raspberry Pi model 3 B
  - Raspberry Pi model 2

## Presentation Mode

The Raspberry Pi Dramble Kubernetes cluster can function entirely 'air-gapped' from the Internet, and this is in fact how the maintainer uses it in presentations.

See the README in the [`testing/presentation`](testing/presentation) directory for instructions for operating the cluster standalone.

## Author

This project was started in 2015 by [Jeff Geerling](https://www.jeffgeerling.com/), author of [Ansible for DevOps](https://www.ansiblefordevops.com/) and [Ansible for Kubernetes](https://www.ansibleforkubernetes.com).
