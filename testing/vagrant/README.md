# Local Vagrant Testing for Raspberry Pi Dramble

This Vagrantfile, when run, will use Vagrant, Ansible, and VirtualBox to build a virtual instance of the Dramble on your local workstation. Make sure you have the juice to run it all, though! You'll need at least 8GB RAM, and a 2+ GHz processor *minimum* if you don't want your computer to choke.

## Install Required Software

  1. Install [Vagrant](http://docs.vagrantup.com/v2/installation/).
  2. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads).
  3. Install [Ansible](http://docs.ansible.com/intro_installation.html).

## Provision the VMs

In this directory, run the following command:

    $ vagrant up

After 10-20 minutes, you should have the infrastructure up and running (assuming there were no errors!).

## Deploy Drupal to the VMs

Once the VMs are up and running, and Ansible provisioning is complete, run the following command (also in this directory):

    $ ansible-playbook -i inventory ../../playbooks/drupal/main.yml

To update to a newer version of the `demo-drupal-8` project, use:

    # Deploy 1.2.1.
    $ ansible-playbook -i inventory ../../playbooks/drupal/main.yml --extra-vars "drupal_version=1.2.1"
