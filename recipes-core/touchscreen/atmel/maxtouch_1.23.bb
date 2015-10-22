
SUMMARY = "mxt-app - command line utility for maXTouch devices"
DESCRIPTION = "mxt-app is a utility for managing Atmel maXTouch touch controllers and other devices that support Atmel Object Based Protocol."
HOMEPAGE = "git://github.com/atmel-maxtouch/mxt-app"

LICENSE ="Atmel Corporation"
LIC_FILES_CHKSUM = "file://LICENSE;md5=8b6acde4490765c7b838377ac61e2d2d"

#rev=c8c653e9159b106d1be212d416860c0baffc6bc0
PV="1.23"
PR="r1"
SRCREV="c8c653e9159b106d1be212d416860c0baffc6bc0"
DEPENDS = "libtool-cross"
DEPENDS_class-native = "libtool-native"

SRC_URI="git://github.com/atmel-maxtouch/mxt-app.git;protocol=git;tag=c8c653e9159b106d1be212d416860c0baffc6bc0"

#########################
#To compile using autotools:
#   ./autogen.sh && make
#
#To cross-compile:
#   ./autogen.sh --host=arm-linux-gnueabi && make
#
#To enable debug:
#./autogen.sh --enable-debug && make
#######################################

inherit autotools texinfo


S="${WORKDIR}/git"
B="${WORKDIR}/build"

#ww
#addtask autogen after do_patch before do_configure
#do_autogen () {
#	echo `pwd`
#	#mkdir -p ${WORKDIR}/image/bin
#	cd ${WORKDIR}/git
#	./autogen.sh --host=arm-linux-gnueabihf --bindir=${WORKDIR}/image
#}

EXTRA_OECONF += "--bindir=${WORKDIR}/build \
				--host=arm-linux-gnueabihf \
"
do_configure () {
	echo `pwd`
	cd ${WORKDIR}/git
	
	[ -f "./autogen.sh" ] && ./autogen.sh 
	[ -f "./Makefile" ] && ./make distclean
	# Remove dependency cache otherwise file renames confuse autoconf
	find . -type d -name \.deps | xargs rm -rf
	autoreconf -v --install
	./configure ${EXTRA_OECONF} $@
	
}


do_install () {
	install -d ${D}${bindir}
	install -d "${D}/usr/lib"
	for i in `find ${B}/.libs` ; do
		[ -f $i ] && [ ! -L $i ] && install -m 644 $i ${D}/usr/lib
	done
	install -m 644 "${B}/libmaxtouch.la" ${D}/usr/lib
	install -m 755 "${B}/mxt-app" ${D}/${bindir}
	
}