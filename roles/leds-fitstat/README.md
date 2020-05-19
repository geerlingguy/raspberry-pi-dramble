LEDs - fit-statUSB
=================

fit-statUSB LED role to install prerequisites and scripts for controlling fit-statUSB-based RGB LEDs with the Raspberry Pi Dramble.

http://fit-pc.com/wiki/index.php/Fit-statUSB

Requirements
------------

N/A

Role Variables
--------------

    fitstat_startup_color: red

The color the fit-statUSB should be after system boot.

Dependencies
------------

N/A

Example Playbook
----------------

    - hosts: pi
      roles:
         - role: leds-fitstat

License
-------

MIT
