do_copyHetronicFirmware () {
         echo "copy Hetronic Firmware"
         cp ${WORKDIR}/am335x-pm-firmware.bin ${S}/firmware
         cp ${WORKDIR}/am335x-pm-firmware.elf ${S}/firmware
     }
     
addtask copyHetronicFirmware after do_configure before do_compile


