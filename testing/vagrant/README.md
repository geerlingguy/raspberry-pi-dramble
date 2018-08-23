# Local Vagrant Testing for Raspberry Pi Dramble

This Vagrantfile, when run, will use Vagrant, Ansible, and VirtualBox to build a virtual instance of the Dramble on your local workstation. Make sure you have the juice to run it all, though! You'll need at least 8GB RAM, and a 2+ GHz processor *minimum* if you don't want your computer to choke.

## Install Required Software

  1. Install [Vagrant](http://docs.vagrantup.com/v2/installation/).
  2. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads).
  3. Install [Ansible](http://docs.ansible.com/intro_installation.html).

## Provision the VMs

In this directory, run the following command:

    $ vagrant up

After 5-10 minutes, you should have the infrastructure up and running.

Add the following to your `/etc/hosts` file so you can access pods via the Kubernetes cluster ingress controller:

    192.168.77.3  cluster.pidramble.test

Then, visit http://cluster.pidramble.test/, and you should see the Drupal site.
