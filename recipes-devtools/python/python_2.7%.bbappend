FILESEXTRAPATHS_prepend := "${THISDIR}/python27:"
SRC_URI += "file://runpy.py;name=runpy"
SRC_URI += "file://pkg_resources.py;name=pkgresources"

EXTRA_OECONF += "\
  --enable-ipv6 \
"


###############
# patch the install...runpy.py,pkg_resources.py
do_install_append () {
	echo `pwd`
	install -d ${D}/usr/lib/python2.7
	
	install -m 0750 ../runpy.py ${D}/usr/lib/python2.7
	install -m 0750 ../pkg_resources.py ${D}/usr/lib/python2.7
}
