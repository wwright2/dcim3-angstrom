#!/bin/bash
#######################
#
# methode-runonce.sh
#######################

function usage () {
	echo " Usage : $0 "
}

completed="/var/.methode.ready"

# Test already run this.
[ -f "$completed" ] && exit 0

# Test opkg cleanup.
[ -f "/etc/opkg/am335x_evm-feed.conf" ] && rm /etc/opkg/am335x_evm-feed.conf

# modify /etc/resolve for development.
[ -r "etc/resolv.conf" ] && rm /etc/resolv.conf
echo "nameserver 10.35.0.68" >/etc/resolv.conf
echo "nameserver 10.35.0.9" >>/etc/resolv.conf
echo "search methode.local" >>/etc/resolv.conf

# Update OPKG dir for development, but also prep for getting gstreamer1.0 packages.
cd /etc/opkg
mkdir archive
cp *.conf archive
rm *conf
cp archive/methode.conf .
cp archive/gstream*.conf .
opkg update

opkg install  	gstreamer1.0-plugins-good  \
	qt4-embedded-plugin-gfxdriver-gfxtransformed	\
	gstreamer1.0-plugins-base-ximagesink \
	gstreamer1.0-plugins-base-ogg \
	gstreamer1.0-plugins-base-encodebin \
	gstreamer1.0-plugins-good-jpeg	\
	gstreamer1.0-plugins-good-png	\
	gstreamer1.0-plugins-good-video4linux2 \
	gstreamer1.0-plugins-base-videotestsrc \
	gstreamer1.0-plugins-base-videoconvert  \
	gstreamer1.0-plugins-good-videofilter


# Enable usbcamera Load modules at bootup.
systemctl enable usbcamera.service
systemctl start usbcamera.service

/etc/init.d/usbcamera-mods.sh start
sleep 2
/etc/init.d/networking restart


# Completion, mark the filesystem.
touch "$completed"


