SUMMARY = "linux wacom "
DESCRIPTION = "	\
Most end users would probably only need to update the /etc/X11/xorg.conf file	\ 
and sometime probably the Wacom X driver as well to use the rich features that	\
Wacom tablets offer.   \
Most end users would probably only need to update the /etc/X11/xorg.conf file	\
and sometime probably the Wacom X driver as well to use the rich features that	\
Wacom tablets offer.  The steps could be as simple as:	\
	\
    $ su											\
    # cp /etc/X11/xorg.conf /etc/X11/xorg.conf.bak	\
    # gedit /etc/X11/xorg.conf		\
"
HOMEPAGE = ""
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://GPL;md5=cbbd794e2a0a289b9dfcc9f513d1996e"

include linuxwacom.inc

SRC_URI = "http://10.35.0.153/dcim3-pkgs/linuxwacom-0.9.4.tar.bz2 \
"


SRC_URI[md5sum] = "3595a9e71acd3e7499355f417dfb2ef8"
SRC_URI[sha256sum] = "a5eb8ffee254da77938fb953698318d91bdb22328d4d1bf9ae44d7f4ab82f47d"

S="${WORKDIR}/${PN}-${PV}"

OEMAKE =" "
do_bootstrap () {
	echo `pwd`
	echo "${S}"
	echo "${D}"
	if [ ! -f ./bootstrap ] ; then
		cd ${S}
		./bootstrap
	fi
		
}
addtask bootstrap after do_unpack before do_configure