
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

PREFERRED_VERSION = "3.2"
SRCPV = "3.2"

#https://git.ti.com/ti-linux-kernel/ti-linux-kernel/commit/c19838d1a8408cfa1b156946fea03bfc96cd380c
 
#SRC_URI = "git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git;protocol=git;nocheckout=1;name=machine"
#http://10.35.0.19/dcim/dcim-controller-gen3.git
#SRC_URI = "http://10.35.0.153/dcim3-pkgs/linux-dcim-3.2.x.tar.gz;protocol=http;name=machine;"
#SRC_URI[machine.md5sum] = "ccc4daa679a3a23d1d282a64b8750cda"

SRC_URI = "http://cti-dcim01/dcim3-pkgs/linux-dcim-3.2.x-r36.tar.gz;protocol=http;name=machine"
SRC_URI[machine.md5sum] = "07cdb8660b3359277f6d76e5590c8cd0"

SRC_URI += "file://am335x-pm-firmware.bin;name=pmfirmwarebin"
SRC_URI[pmfirmwarebin.md5sum] = "380b1cc986d87456658ac88fef849003"
SRC_URI += "file://am335x-pm-firmware.elf;name=pmfirmwareelf"
SRC_URI[pmfirmwareelf.md5sum] = "acf9865a4c6c8bc5bbba2472ca5a5d9c"
SRC_URI += "file://defconfig;name=defconfig"
SRC_URI[defconfig.md5sum] = "00d9c8a136be73cafc2e8480af0085e6"
SRC_URI += "file://dcim_defconfig;name=dcimconfig"
SRC_URI += "file://rollrev.sh;name=rollrev"
SRC_URI += "file://cpsw.c;name=cpsw"

CMDLINE = "console=ttyO0,115200 rootwait root=/dev/mmcblk0p2 ip=dhcp"
KERNEL_IMAGETYPE = "uImage"

S = "${WORKDIR}/linux"
PACKAGES =+ "firmware firmware-dbg"
FILES_firmware = "${binddir}/* \
				 ${libexecdir}"
FILES_firmware-dbg = "FILES_${PN}-dbg \
				${KERNEL_SRC_PATH}/firmware/.debug/*"

do_myconfigure () {
	echo `pwd`
	[ -f ${S}/.config.old ] && rm ${S}/.config.old
	cp ../am335x-pm-firmware.* ${S}/firmware
	cp ../dcim_defconfig ${S}/
	cp ../dcim_defconfig ${S}/arch/arm/configs/dcim_defconfig
	
}
do_precompile () {
	cp ../dcim_defconfig ${S}/.config
	cp ../cpsw.c ${S}/drivers/net/ethernet/ti/cpsw.c
}

addtask precompile after do_configure before do_compile
addtask myconfigure after do_unpack before do_configure


