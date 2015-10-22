#!/bin/sh

# hdmi.sh file to start the LCD on startup
# chmod +x /etc/init.d/hdmi.sh 
# cd /etc/rc5.d 
# ln -s ../init.d/hdmi.sh S99hdmi
# reboot to check the HDMI display

i2cset -y 3 0x39 0x41 0x10

