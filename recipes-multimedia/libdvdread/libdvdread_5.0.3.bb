SUMMARY = "DVD access multimeda library"
SECTION = "libs/multimedia"
LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://COPYING;md5=64e753fa7d1ca31632bc383da3b57c27"

SRC_URI = "git://git.videolan.org/libdvdread.git;protocol=git"

#tag 5.0.3
SRCREV="2b8f60f0c4efd85f17116a5443851d4bb4a288b7"

inherit autotools lib_package binconfig pkgconfig


PV = "5.0.3+gitr${SRCPV}"
PR = "r1"

PROVIDES = "libdvdread"
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