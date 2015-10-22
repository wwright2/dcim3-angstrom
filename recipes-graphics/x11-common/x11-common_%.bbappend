
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://etc "

do_install_append() {
    #
	cp -R ${S}/etc ${D}${sysconfdir}
	chmod -R 755 ${D}${sysconfdir}
	find ${D}${sysconfdir} -type f -name \*~ -exec rm -rf {} \;
}

# see also i2c-tools_%.bbappend

