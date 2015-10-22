SECTION = "kernel firmware"
DESCRIPTION = "Linux kernel Methode am335x pm firmware"
LICENSE = ""

S = "${WORKDIR}/git"

addtask install after do_configure
do_install () {        
         echo "copy Hetronic Firmware"
         cp ${WORKDIR}/am335x-pm-firmware.bin ${S}/firmware
         cp ${WORKDIR}/am335x-pm-firmware.elf ${S}/firmware
}

