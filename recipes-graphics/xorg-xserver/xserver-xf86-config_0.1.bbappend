FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_methode = " file://xorg.conf.d/10-evdev.conf	\
				file://xorg.conf	"

do_install_append_methode () {
	install -d ${D}/${sysconfdir}/X11/xorg.conf.d/
	install -m 0644 ${WORKDIR}/xorg.conf.d/* ${D}/${sysconfdir}/X11/xorg.conf.d/
	install -m 0644 ${WORKDIR}/xorg.conf ${D}/${sysconfdir}/X11/
}

FILES_${PN}_methode += "${sysconfdir}/X11/xorg.conf ${sysconfdir}/X11/xorg.conf.d/*"

EXTRA_OECONF += "	\
					--disable-pam	\
"