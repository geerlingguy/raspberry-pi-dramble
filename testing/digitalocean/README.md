# DigitalOcean Testing for Raspberry Pi Dramble

The included `provision.yml` file, when run, will provision five servers in your DigitalOcean account that you can use to test the Raspberry Pi Dramble project on the public Internet.

**NOTE**: These servers will be accessible to the public, *and* you will be charged a fee for each server as long as it's running (something like $0.01/hour, so not much if you destroy them quickly). This provisioning setup is meant for experimental/testing purposes only. If you don't destroy the droplets once you're finished testing, you put sensitive information on them and they get hacked or 'repurposed'... you've been warned!

## Provision the servers

Pre-suppositions: You have a DigitalOcean account, and you have a [Personal Access Token](https://www.digitalocean.com/community/tutorials/how-to-use-the-digitalocean-api-v2#how-to-generate-a-personal-access-token). Additionally, you have `dopy` and Ansible installed on your workstation (install `dopy` with `sudo pip install dopy`).

To build the droplets and configure them using Ansible, follow these steps (within this directory):

  1. Set `digitalocean_api_token` in `config.yml` (in the project root) to your Access Token copy `example.config.yml` to `config.yml` if not already done.
  2. Run `ansible-playbook provision.yml`, and wait until the Droplets are all provisioned.
  3. Copy the `example.inventory` file in this directory to `inventory`, and edit it to use the IP addresses for the servers in your [DigitalOcean Droplets list](https://cloud.digitalocean.com/droplets).

Make sure you can connect to the servers by pinging them with Ansible:

    ansible all -i inventory -m ping

It should show a `SUCCESS` message for each server; you will likely need to type `yes` a few times to accept all the hostkeys. (Note that certain versions of Ansible don't work correctly with new hosts/untrusted hostkeys, so you might have to ssh into each server to accept its hostkey the first time).

## Deploy the Dramble configuration

Run the main setup playbook (from within *this* directory):

    ansible-playbook -i inventory ../../main.yml

After a few minutes, everything should be deployed, and the Dramble cluster will be ready for Drupal deployment.

> You could run the `main.yml` playbook directly from the `provision.yml` playbook if you wanted, but this would require a little extra reconfiguration, and this DigitalOcean setup is mainly meant for testing purposes, so I'm not going to devote the time to maintaining it for that level of use/ease.

## Deploy Drupal to the DigitalOcean Dramble

Run the Drupal install playbook (from within *this* directory):

    ansible-playbook -i inventory ../../playbooks/drupal/main.yml

After a few minutes, everything should be deployed, and the Dramble cluster will be serving up Drupal 8!

## Destroy the DigitalOcean Droplets

To destroy the droplets you used for testing, edit `config.yml` and change `digitalocean_droplet_state` to `absent`, then run the `provision.yml` playbook again.

**Note**: Log in and confirm all the Droplets are destroyed; sometimes the DO API might not destroy all of them in one playbook run.
