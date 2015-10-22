# linux-yocto-custom.bb:
#
#   An example kernel recipe that uses the linux-yocto and oe-core
#   kernel classes to apply a subset of yocto kernel management to git
#   managed kernel repositories.
#
#   To use linux-yocto-custom in your layer, create a
#   linux-yocto-custom.bbappend file containing at least the following
#   lines:
#
#     FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
#     COMPATIBLE_MACHINE_yourmachine = "yourmachine"
#
#   You must also provide a Linux kernel configuration. The most direct
#   method is to copy your .config to files/defconfig in your layer,
#   in the same directory as the bbappend and add file://defconfig to
#   your SRC_URI.
#
#   To use the yocto kernel tooling to generate a BSP configuration
#   using modular configuration fragments, see the yocto-bsp and
#   yocto-kernel tools documentation.
#
# Warning:
#
#   Building this example without providing a defconfig or BSP
#   configuration will result in build or boot errors. This is not a
#   bug.
#
#
# Notes:
#
#   patches: patches can be merged into to the source git tree itself,
#            added via the SRC_URI, or controlled via a BSP
#            configuration.
#   
#   example configuration addition:
#            SRC_URI += "file://smp.cfg"
#   example patch addition (for kernel v3.4 only):
#            SRC_URI += "file://0001-linux-version-tweak.patch
#   example feature addition (for kernel v3.4 only):
#            SRC_URI += "file://feature.scc"
#

inherit kernel
require recipes-kernel/linux/linux-yocto.inc

# Override SRC_URI in a bbappend file to point at a different source
# tree if you do not want to build from Linus' tree.
SRC_URI = "git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git;protocol=git;nocheckout=1;name=machine"
#SRC_URI = "git://git.ti.com/ti-linux-kernel/ti-linux-kernel.git;protocol=git;nocheckout=1;name=machine"

# Override SRCREV to point to a different commit in a bbappend file to
# build a different release of the Linux kernel.
# tag: v3.4 76e10d158efb6d4516018846f60c2ab5501900bc
# tag: v3.2 805a6af8dba5dfdd35ec35dc52ec0122400b2610 from TI git://git.ti.com/ti-linux-kernel/ti-linux-kernel.git
SRCREV_machine="805a6af8dba5dfdd35ec35dc52ec0122400b2610"

#SRC_URI = "http://10.35.0.19/dcim/dcim-controller-gen3.git"
#SRCREV_machine="73de3b36df256b8bb531a68c47183fbb695568b4"

DEFAULT_PREFERENCE = "1"
KMACHINE="am335x-evm"
LINUX_VERSION ?= "3.2"
LINUX_VERSION_EXTENSION ?= "-methode"
KERNEL_IMAGETYPE = "uImage"

PREFERRED_PROVIDER_virtual/kernel = "linux-methode"
PREFERRED_VERSION_linux-methode = "3.2"
PREFERRED_PROVIDER_kernel-base = "linux-methode"
PREFERRED_PROVIDER_kernel-image = "linux-methode"

PREFERRED_PROVIDER_linux/kernel_remove ="linux-am335x-psp"
PREFERRED_PROVIDER_linux/kernel_remove ="linux-linaro-stable-vexpress"

CMDLINE = "console=ttyO0,115200 rootwait root=/dev/mmcblk0p2 ip=dhcp"


PR = "r30"
PV = "${LINUX_VERSION}+git${SRCPV}"

# Override COMPATIBLE_MACHINE to include your machine in a bbappend
# file. Leaving it empty here ensures an early explicit build failure.
#COMPATIBLE_MACHINE = "(^$)"
COMPATIBLE_MACHINE = "ti33x|am335x-evm"

SRC_URI += "file://defconfig;name=defconfig"
SRC_URI[defconfig.md5sum] = "00d9c8a136be73cafc2e8480af0085e6"

SRC_URI += "file://0001-linux-bangalore-3.2.patch;name=patch"
SRC_URI[patch.md5sum] = "9ac7aa17f9c036d057289363d4e4017b"

SRC_URI += "file://am335x-pm-firmware.bin;name=pmfirmwareelf"
SRC_URI[pmfirmwareelf.md5sum] = "380b1cc986d87456658ac88fef849003"
SRC_URI += "file://am335x-pm-firmware.elf;name=pmfirmwareelf"
SRC_URI[pmfirmwareelf.md5sum] = "acf9865a4c6c8bc5bbba2472ca5a5d9c"

PACKAGES =+ "firmware firmware-dbg"
FILES_firmware = "${binddir}/* \
				 ${libexecdir}"
FILES_firmware-dbg = "FILES_${PN}-dbg \
				${KERNEL_SRC_PATH}/firmware/.debug/*"

S="${WORKDIR}/linux"

do_configure_append () {
	cp ../am335x-pm-firmware.* ${S}/firmware
}
