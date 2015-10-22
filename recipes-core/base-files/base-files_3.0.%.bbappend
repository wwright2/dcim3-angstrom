FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI += "file://display-settings.sh;name=displaysettings"
SRC_URI += "file://methode-env.sh;name=profile"
SRC_URI += "file://usbcamera-mods.sh;name=usbcamera"
SRC_URI += "file://v4l2_modules.conf;name=v4l2"
SRC_URI += "file://snapshot.sh;name=snapshot"
SRC_URI += "file://usbcamera.service;name=usbcamera"
SRC_URI += "file://opkg-methode.conf;name=opkgmethode"
SRC_URI += "file://methode-runonce.sh;name=methoderunonce"


VOLATILE_LOG_DIR = ""

do_install_append () {
	echo `pwd`
	install -d ${D}/etc/profile.d
	install -d ${D}/etc/rc5.d
	install -d ${D}/etc/methode
	install -d ${D}/etc/init.d
	install -d ${D}/etc/systemd/system 
	install -d ${D}/etc/opkg 
	install -d ${D}/usr/bin 

	
	install -m 0750 display-settings.sh ${D}/etc/profile.d
	install -m 0644 methode-env.sh ${D}/etc/profile.d
	install -m 0644 usbcamera.service ${D}/etc/systemd/system
	install -m 0644 opkg-methode.conf ${D}/etc/opkg/methode.conf
	install -m 0644 methode-runonce.sh ${D}/usr/bin/
	
	# add modules to handle Camera, 
	# ...todo: create udev rules instead of this hack.
	install -m 0644 v4l2_modules.conf ${D}/etc/methode
	install -m 0754 usbcamera-mods.sh ${D}/etc/init.d
	install -m 0754 snapshot.sh ${D}/usr/bin
	cd ${D}/etc/rc5.d
	ln -s ../init.d/usbcamera-mods.sh ./S96usbcamera
	# end add modules.
}

