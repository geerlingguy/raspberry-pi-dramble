LEDs - Blinkstick
=================

Blinkstick LED role to install prerequisites and scripts for controlling Blinkstick-based RGB LEDs with the Raspberry Pi Dramble.

Requirements
------------

N/A

Role Variables
--------------

    blinkstick_startup_color: red

The color the Blinkstick should be after system boot.

Dependencies
------------

N/A

Example Playbook
----------------

    - hosts: pi
      roles:
         - role: leds-blinkstick

License
-------

MIT
