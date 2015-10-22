SUMMARY = "Library to navigate DVD disks"
SECTION = "libs/multimedia"
LICENSE = "GPLv2+"
HOMEPAGE ="http://www.mpucoder.com/dvd/"
LIC_FILES_CHKSUM = "file://COPYING;md5=94d55d512a9ba36caa9b7df079bae19f"

#v5.0.3
SRC_URI = "git://git.videolan.org/libdvdnav.git;protocol=git;name=libdvdnav"
SRCREV="5fb919774444aa382f6e02cb63801c82f2c38325"

#SRC_URI[md5sum] = "ab7a19d3ab1a437ae754ef477d6231a4"
#SRC_URI[sha256sum] = "0bea15da842a4b04a482b009d72dcc6d9c9524ccc1bf67e5748319ec5ada8097"

PV = "5.0.3+gitr${SRCPV}"
PR = "r1"

PROVIDES = "libdvdnav"

DEPENDS= " libdvdread "

inherit autotools lib_package binconfig pkgconfig

CONFIGUREOPTS_remove = "--disable-silent-rules"

S = "${WORKDIR}/git"

EXTRA_OECONF = " \
    --prefix=/usr \
    --mandir=${mandir} \
    --target=${SIMPLE_TARGET_SYS} \
    \
    "
EXTRA_OECONF_append_armv7a = " --enable-armv6 --enable-neon"