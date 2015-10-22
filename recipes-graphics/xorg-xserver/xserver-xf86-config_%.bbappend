#FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
#SRC_URI_append_methode = " file://xorg.conf.d/10-evdev.conf	\
#				file://xorg.conf	"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI += "file://methode-xorg.conf;name=xorgconf"
SRC_URI += "file://10-evdev.conf;name=evdev"


do_install_append () {
	echo `pwd`
	install -d ${D}/${sysconfdir}/X11/xorg.conf.d/
	install -m 0644 ../10-evdev.conf ${D}/${sysconfdir}/X11/xorg.conf.d/
	install -m 0644 ../methode-xorg.conf ${D}/${sysconfdir}/X11/xorg.conf
}

#FILES_${PN}_methode += "${sysconfdir}/X11/xorg.conf ${sysconfdir}/X11/xorg.conf.d/*"
