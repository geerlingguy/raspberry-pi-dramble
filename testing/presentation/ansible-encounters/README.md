# Close Encounters of the Ansible Kind

This playbook uses Ansible to _literally_ orchestrate the five musical tones used in the movie _Close Encounters of the Third Kind_ using the [SoX](http://sox.sourceforge.net) CLI tone-generating program and [Blinksticks](https://www.blinkstick.com) plugged into the Raspberry Pi.

You could do this with just one Blinkstick and one computer... or a LED board or some other signage. But that's just boring.

## Prerequisites

  - Install SoX: `brew install sox`
  - Install the Blinkstick library: `pip install blinkstick` (if running on the Pis)

## Usage

In this directory, run:

    ansible-playbook main.yml

> The Blinkstick commands will only work if you have a blinkstick attached to the Pis, for obvious reasons.

## How Does it Work?

All the tasks in this playbook have a note as the task `name` that is mapped to a particular frequency and length by the `tones.py` custom Ansible Callback plugin. This callback plugin listens for tasks (and is whitelisted in `ansible.cfg` so it is used when running the playbook). It calls out to the `play` command via Python to produce musical notes on the host machine.

If you just want to play the tones on your computer—assuming you already have `play` installed:

    play -q -n synth 1 sin 783.99 \
      && play -q -n synth 1 sin 880.00 \
      && play -q -n synth 1 sin 698.46 \
      && play -q -n synth 1 sin 349.23 \
      && play -q -n synth 2 sin 523.25
