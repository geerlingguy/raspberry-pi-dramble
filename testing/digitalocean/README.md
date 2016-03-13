# DigitalOcean Testing for Raspberry Pi Dramble

The included `provision.yml` file, when run, will provision five servers in your DigitalOcean account that you can use to test the Raspberry Pi Dramble project on the public Internet.

**NOTE**: These servers will be accessible to the public, *and* you will be charged a fee for each server as long as it's running (something like $0.01/hour, so not much if you destroy them quickly). This provisioning setup is meant for experimental/testing purposes only. If you don't destroy the droplets once you're finished testing, you put sensitive information on them and they get hacked or 'repurposed'... you've been warned!

## Provision the servers

Pre-suppositions: You have a DigitalOcean account, and you have a [Personal Access Token](https://www.digitalocean.com/community/tutorials/how-to-use-the-digitalocean-api-v2#how-to-generate-a-personal-access-token). Additionally, you have `dopy` and Ansible installed on your workstation (install `dopy` with `sudo pip install dopy`).

To build the droplets and configure them using Ansible, follow these steps (within this directory):

  1. Set `digitalocean_api_token` in `config.yml` (in the project root) to your Access Token copy `example.config.yml` to `config.yml` if not already done.
  2. Run `ansible-playbook provision.yml`.

After a few minutes (depending on DigitalOcean's current server provisioning speed), the servers will be provisioned and ready for you to run the main Ansible playbook on them.

## Deploying the Dramble configuration

  1. Edit the `inventory` file included in this directory to use the IP addresses for the servers in your DigitalOcean droplets dashboard (https://cloud.digitalocean.com/droplets).
  2. Run the main setup playbook (from within *this* directory):
    ```
    ansible-playbook -i inventory ../../main.yml
    ```
  3. After a few minutes, everything should be deployed, and the Dramble cluster will be ready for Drupal deployment.

> You could run the `main.yml` playbook directly from the `provision.yml` playbook if you wanted, but this would require a little extra reconfiguration, and this DigitalOcean setup is mainly meant for testing purposes, so I'm not going to devote the time to maintaining it for that level of use/ease.

## Deploying Drupal to the DigitalOcean Dramble

  1. Run the drupal install playbook (from within *this* directory):
    ```
    ansible-playbook -i inventory ../../playbooks/drupal/main.yml
    ```
  2. After a few minutes, everything should be deployed, and the Dramble cluster will be serving up Drupal 8!

## Destroying the DigitalOcean Droplets

To destroy the droplets you used for testing, edit `provision.yml` and replace `present` with `absent` on the line that reads `state: "{{ item.state | default('present') }}"`, then run the `provision.yml` playbook again.
