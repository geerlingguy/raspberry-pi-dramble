# Raspberry Pi RGB LED control through RPi.GPIO

This folder contains Python scripts that can control single LEDs or RGB LEDs. These instructions assume you're using common cathode LEDs.

## Wiring the Raspberry Pi

<img src="https://raw.githubusercontent.com/geerlingguy/raspberry-pi-dramble/master/images/rgb-led-wiring.jpg" alt="Raspberry Pi RGB LED wiring diagram" />

(Open the file `images/RGB LED Wiring.fzz` with [Fritzing](http://fritzing.org/) to see full wiring diagram details).

You will need 3 470Ω resistors (one for each color lead), an RGB LED, a breadboard/perfboard to assemble everything, and a way to make connections between the Pi's GPIO pins and everything else.

In my case, since I am using a common cathode-style LED (where ground goes to the longest leg/'cathode', and +3.3VDC goes to each of the color legs), I wired one of the ground pins on the Pi to the cathode, then GPIO 17, 18, and 27 to red, green, and blue on the LED.

## Using the scripts

Each of the scripts has a unique purpose:

  - `rgb.py`: Turn on one of the LED colors (or turn them all off with `off`. Color stays set after the script exits. For example, `sudo python rgb.py red` would set red.
  - `fade.py`: Fade colors on the LED (edit the file to choose which color to fade) using PWM. Fading stops when the script exits.
  - `colors.py`: Set arbitrary colors on the LED using individual red/green/blue values (using the common 0-255 format). For example, `sudo python colors.py 255 128 0` would set orange.
