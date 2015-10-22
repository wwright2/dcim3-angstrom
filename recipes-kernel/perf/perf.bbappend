LICENSE = "GPL-2"
LIC_FILES_CHKSUM = "file://COPYING;md5=d7810fab7487fb0aad327b76f1be7cd7"

PV = "3.2.17"
BPN="build."

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI = "${METHODE_MIRROR}/dcim3-pkgs/linux-tools_${PV}.orig.tar.gz \
			${DEBIAN_MIRROR}/main/l/linux-tools/linux-tools_${PV}.orig.tar.gz \
"
#SRC_URI += " \
#           file://0001-perf-tools-Fix-arm64-build-error.patch \
#           file://0001-perf-tools-Fix-build-breakage-on-arm64-targets.patch \
#"

SRC_URI[md5sum] = "05a97fba856e09a4f3b4fe769ed2bef8"
SRC_URI[sha256sum] = "9676c2c130cf9671bcba433d098d7d97e1a6d108c0bce4e2e5eefa1731539e6b"

S = "${WORKDIR}/linux-tools-${PV}"
B = "${WORKDIR}/build.linux-tools-${PV}"

do_compile_prepend() {
    mkdir -p ${S}/include/generated
    echo "#define UTS_RELEASE \"${PV}\"" > ${S}/include/generated/utsrelease.h
}
