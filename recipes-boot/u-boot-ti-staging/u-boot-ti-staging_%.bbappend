FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
UBOOT_MACHINE = "dcim_config"
#UBOOT_MACHINE = "am335x_evm_config"

PREFERRED_VERSION_u-boot = "2013.01.01"

SRC_URI += "file://0001-u-boot-2013.01.01-cti-dcim.patch;name=patch"
SRC_URI[patch.md5] = "1b9c0479d7d4a59906b1677ef79eb558"
LIC_FILES_CHKSUM = "file://README;md5=35cbc54e665b3ffb33ffb26ef322afb8"
PV = "2013.01.01"

# This version of u-boot is meant for 3.2 kernel which doesn't support device tree.
# you have to:
# cat uImage uImage.dtb > myuimage
# mount /dev/sdb1 mnt/boot
# cp myuimage mnt/boot/uImage

BRANCH = "ti-u-boot-2013.01.01-amsdk-06.00.00.00"
SRCREV = "540aa6fbb0c9274bda598f7e8819ed28259cad6b"

# Set the name of the SPL that will built so that it is also packaged with u-boot.
SPL_BINARY = "MLO"

S="${WORKDIR}/git"

