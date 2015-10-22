LICENSE = "GPLv3"
LIC_FILES_CHKSUM = "file://COPYING;md5=ea116a7defaf0e93b3bb73b2a34a3f51"



PR = "r1"
PV = "5.8.1"

#SRC_URI = "http://mmonit.com/monit/dist/monit-${PV}.tar.gz;name=monit"
SRC_URI = "file://monit-${PV}.tar.gz;name=monit"
SRC_URI += "file://enable-etc-monit.d-include.patch;name=patch;force=1"
SRC_URI += "file://init;name=init"
SRC_URI[patch.md5sum] = "025c9f8b9140604b1e3badd8f090a1eb"

SRC_URI[monit.md5sum] = "9467328f1da0b644a766a387443db2ea"
SRC_URI[monit.sha256sum] = "a25e4b79257ac29ebaf46605dccb7ed693c8e001669c0ccc8feb22e7d4c870e5"

