
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI += "file://rbconfig.rb;name=rbconfig"
#SRC_URI[rbconfig]="05f84fe0f6d8fb4fd9fd36ec60c674ed"

do_install_append () {
	echo `pwd`
	install -d ${D}/usr/lib/ruby/arm-linux-eabi
	install -m 0644 ${WORKDIR}/rbconfig.rb ${D}/usr/lib/ruby/arm-linux-eabi/rbconfig.rb
}


FILES_${PN}_methode += "${libdir}/ruby/arm-linux-eabi/rbconfig.rb"
