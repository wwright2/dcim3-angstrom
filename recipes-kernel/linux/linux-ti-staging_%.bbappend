
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

#require methode.inc

PREFERRED_VERSION = "3.2"

#https://git.ti.com/ti-linux-kernel/ti-linux-kernel/commit/c19838d1a8408cfa1b156946fea03bfc96cd380c
 
#SRC_URI = "git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git;protocol=git;nocheckout=1;name=machine"
#http://10.35.0.19/dcim/dcim-controller-gen3.git
#SRC_URI = "http://10.35.0.19/dcim/dcim-controller-gen3.git;protocol=http;nocheckout=1;name=machine"


#SRC_URI += "file://0001-linux-bangalore-3.2.patch;name=patch"
#SRC_URI[patch.md5sum] = "5525e77058f9bdac0c2612d246cbd57e"

SRC_URI += "file://am335x-pm-firmware.bin;name=pmfirmwareelf"
SRC_URI[pmfirmwareelf.md5sum] = "380b1cc986d87456658ac88fef849003"
SRC_URI += "file://am335x-pm-firmware.elf;name=pmfirmwareelf"
SRC_URI[pmfirmwareelf.md5sum] = "acf9865a4c6c8bc5bbba2472ca5a5d9c"

#SRC_URI[kernel.md5sum] = "21abf8029d6678e519405df055a3ee18"

SRC_URI += "file://defconfig;name=defconfig"
SRC_URI[defconfig.md5sum] = "00d9c8a136be73cafc2e8480af0085e6"



CMDLINE = "console=ttyO0,115200 rootwait root=/dev/mmcblk0p2 ip=dhcp"
KERNEL_IMAGETYPE = "uImage"

#S = "${WORKDIR}/git"
#KERNEL_CONFIG_DIR = "${S}/ti_config_fragments"
#KERNEL_CONFIG_FRAGMENTS_remove = " ${KERNEL_CONFIG_DIR}/am33xx_only.cfg"

#KERNEL_CONFIG_FRAGMENTS += " ${S}/../methode.cfg"

#KERNEL_CONFIG_FRAGMENTS += " ${KERNEL_CONFIG_DIR}/debug_options.cfg"

PACKAGES =+ "firmware firmware-dbg"
FILES_firmware = "${binddir}/* \
				 ${libexecdir}"
FILES_firmware-dbg = "FILES_${PN}-dbg \
				${KERNEL_SRC_PATH}/firmware/.debug/*"




