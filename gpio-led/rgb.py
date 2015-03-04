# Turn on or off R, G, and B colors on an RGB LED.
#
# @author Jeff Geerling, 2015

import RPi.GPIO as GPIO

GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)

# LED pin mapping.
red = 17
green = 27
blue = 18

# GPIO Setup.
GPIO.setup(red, GPIO.OUT)
GPIO.setup(green, GPIO.OUT)
GPIO.setup(blue, GPIO.OUT)

# Set individual colors on or off.
GPIO.output(red, 1)
GPIO.output(green, 0)
GPIO.output(blue, 0)
