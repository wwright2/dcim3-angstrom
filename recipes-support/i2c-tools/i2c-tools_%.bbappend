
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

#SRC_URI = "file://monit-${PV}.tar.gz;name=monit"
SRC_URI += "file://hdmi.sh;name=hdmish"

do_compile_prepend() {
    cp ${WORKDIR}/Module.mk ${S}/eepromer/
    sed -i 's#/usr/local#/usr#' ${S}/Makefile
    echo "include eepromer/Module.mk" >> ${S}/Makefile
}

do_install_append() {
    install -d ${D}${includedir}/linux
    install -m 0644 include/linux/i2c-dev.h ${D}${includedir}/linux/i2c-dev-user.h
    rm -f ${D}${includedir}/linux/i2c-dev.h
    
    #
    [ -d "${D}/etc/rc5.d" ] && rm -rf ${D}/etc/rc5.d
    install -d ${D}/etc/init.d
    install -d ${D}/etc/rc5.d
    install -m 0750 ../hdmi.sh ${D}/etc/init.d
    cd ${D}/etc/rc5.d
    ln -s ../init.d/hdmi.sh ./S99hdmi
}
