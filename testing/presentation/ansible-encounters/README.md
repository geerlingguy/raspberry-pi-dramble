# Close Encounters of the Ansible Kind

This playbook uses Ansible to _literally_ orchestrate the five musical tones used in the movie _Close Encounters of the Third Kind_ using the SoX CLI tone-generating program and Blinksticks plugged into the Raspberry Pi.

You could do this with just one Blinkstick and one computer... or a LED board or some other signage. But that's just boring.

## Prerequisites

Install SoX: `brew install sox`

## Usage

In this directory, run:

    ansible-playbook main.yml

> The Blinkstick commands will only work if you have a blinkstick attached to the Pis, for obvious reasons.

## How Does it Work?

All the tasks in this playbook have individual `freq` args that are used by the `tones.py` custom Ansible Callback plugin. This callback plugin listens for tasks (and is whitelisted in `ansible.cfg` so it is used when running the playbook). It calls out to the `play` command via Python to produce musical notes on the host machine.
