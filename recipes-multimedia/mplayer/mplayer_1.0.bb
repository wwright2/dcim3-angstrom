SUMMARY = "Open Source multimedia player"
SECTION = "multimedia"
HOMEPAGE = "http://www.mplayerhq.hu/"
DEPENDS = "libvpx libdvdread libdvdnav libtheora virtual/libsdl ffmpeg xsp zlib \
           libpng jpeg liba52 freetype fontconfig alsa-lib lzo ncurses \
           libxv virtual/libx11 libass speex faad2"

RDEPENDS_${PN} = "mplayer-common"
PROVIDES = "mplayer"
RPROVIDES_${PN} = "mplayer"
RCONFLICTS_${PN} = "mplayer"

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://LICENSE;md5=91f1cb870c1cc2d31351a4d2595441cb"

PNBLACKLIST[mplayer] ?= "Requires newer libav which has negative D_P"

SRC_URI = "git://repo.or.cz/mplayer.git \
    file://0001-configure-don-t-disable-ASS-support-when-explicitly-.patch \
"

SRCREV = "1fa9b44114b9517c4cbebabf57eb135fc1487d9d"

ARM_INSTRUCTION_SET = "arm"

PV = "1.1.1+gitr${SRCPV}"
PR = "r14"

PARALLEL_MAKE = ""

S = "${WORKDIR}/git"

FILES_${PN} = "${bindir}/mplayer ${libdir} /usr/etc/mplayer/"
CONFFILES_${PN} += "/usr/etc/mplayer/input.conf \
                    /usr/etc/mplayer/example.conf \
                    /usr/etc/mplayer/codecs.conf \
"

inherit autotools-brokensep pkgconfig

EXTRA_OECONF = " \
    --prefix=/usr \
    --mandir=${mandir} \
    --target=${SIMPLE_TARGET_SYS} \
    \
    --disable-lirc \
    --disable-lircc \
    --disable-joystick \
    --disable-vm \
    --disable-xf86keysym \
    --enable-tv \
    --enable-tv-v4l2 \
    --disable-tv-bsdbt848 \
    --enable-rtc \
    --enable-networking \
    --disable-smb \
    --enable-dvdnav \
    --enable-dvdread \
    --disable-enca \
    --disable-ftp \
    --disable-vstream \
    \
    --disable-gif \
    --enable-png \
    --enable-jpeg \
    --disable-libcdio \
    --disable-qtx \
    --disable-xanim \
    --disable-real \
    --disable-xvid \
    \
    --enable-speex \
    --enable-theora \
    --disable-ladspa \
    --disable-libdv \
    --enable-mad \
    --disable-xmms \
    --disable-musepack \
    \
    --disable-gl \
    --enable-sdl \
    --disable-caca \
    --disable-directx \
    --disable-dvb \
    --enable-xv \
    --disable-vm \
    --disable-xinerama \
    --enable-x11 \
    --disable-directfb \
    --disable-tga \
    --disable-pnm \
    --disable-md5sum \
    \
    --enable-alsa \
    --enable-ossaudio \
    --disable-pulse \
    --disable-jack \
    --disable-openal \
    --enable-select \
    \
    --extra-libs=' -lXext -lX11 -lvorbis -ltheoradec -lasound -ldvdnav -ldvdread' \
"
# -ltheoradec is missing in:
# libmpcodecs/vd_theora.o: undefined reference to symbol 'theora_decode_init@@libtheora.so.1.0'

EXTRA_OECONF_append_armv6 = " --enable-armv6"
EXTRA_OECONF_append_armv7a = " --enable-armv6 --enable-neon"

PACKAGECONFIG[mad] = "--enable-mad,--disable-mad,libmad"
PACKAGECONFIG[a52] = "--enable-liba52,--disable-liba52,liba52"
PACKAGECONFIG[lame] = ",,lame"

FULL_OPTIMIZATION = "-fexpensive-optimizations -fomit-frame-pointer -frename-registers -O4 -ffast-math"
BUILD_OPTIMIZATION = "${FULL_OPTIMIZATION}"

CFLAGS_append = " -I${D}/usr/include/dvdread -I${D}/usr/include/dvdnav"

do_configure() {
    sed -i 's|/usr/include|${STAGING_INCDIR}|g' ${S}/configure
    sed -i 's|/usr/lib|${STAGING_LIBDIR}|g' ${S}/configure
    sed -i 's|/usr/\S*include[\w/]*||g' ${S}/configure
    sed -i 's|/usr/\S*lib[\w/]*||g' ${S}/configure
    sed -i 's|_install_strip="-s"|_install_strip=""|g' ${S}/configure
    sed -i 's|HOST_CC|BUILD_CC|' ${S}/Makefile

    export SIMPLE_TARGET_SYS="$(echo ${TARGET_SYS} | sed s:${TARGET_VENDOR}::g)"
    ./configure ${EXTRA_OECONF}
    
}

do_compile () {
    oe_runmake
}

do_install() {
    oe_runmake 'DESTDIR=${D}' 
    install -d ${D}/usr/etc/mplayer
    install -d ${D}/usr/bin
    install -m 0755 ${S}/mplayer ${D}/usr/bin
    install ${S}/etc/input.conf ${D}/usr/etc/mplayer/
    install ${S}/etc/example.conf ${D}/usr/etc/mplayer/
    install ${S}/etc/codecs.conf ${D}/usr/etc/mplayer/
    #[ -e ${D}/usr/lib ] && rmdir ${D}/usr/lib
}