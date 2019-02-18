LEDs - GPIO
===========

GPIO LED role to install prerequisites and scripts for controlling custom GPIO-based RGB LEDs with the Raspberry Pi Dramble.

Requirements
------------

N/A

Role Variables
--------------

    leds_pin_red: 17
    leds_pin_green: 27
    leds_pin_blue: 18

A mapping of GPIO pin numbers to color legs on the RGB LED.

Dependencies
------------

N/A

Example Playbook
----------------

    - hosts: pi
      roles:
         - role: leds-gpio

License
-------

MIT
