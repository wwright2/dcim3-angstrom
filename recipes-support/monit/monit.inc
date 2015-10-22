SUMMARY = "Monit is a free open source utility for managing and monitoring, processes, programs, files, directories and filesystems on a UNIX system. Monit conducts automatic maintenance and repair and can execute meaningful causal actions in error situations."
HOMEPAGE = "http://mmonit.com/monit/"
BUGTRACKER = "https://bitbucket.org/tildeslash/monit/issues?status=new&status=open"
SECTION = "console/network"

DEPENDS = "openssl libpam gettext"
#DEPENDS = " libpam libevent openssl linux-libc-headers"

INITSCRIPT_NAME = "monit"
INITSCRIPT_PARAMS = "defaults 99"
inherit autotools-brokensep update-rc.d

S="${WORKDIR}/monit-${PV}"

EXTRA_OECONF = " \
	libmonit_cv_setjmp_available=no \
	libmonit_cv_vsnprintf_c99_conformant=no \
	--with-pam --with-ssl \
	--with-ssl-lib-dir=${STAGING_LIBDIR} \
	--with-ssl-incl-dir=${STAGING_INCDIR} \
	--includedir=${STAGING_INCDIR} \
	"
	
do_bootstrap () {
	cd  ${S}/libmonit 
	./bootstrap	
	cd ..
	./bootstrap
}
addtask bootstrap after do_patch before do_configure

do_install_append() {
	install -d ${D}${sysconfdir}/init.d/
	install -m 755 ${WORKDIR}/init ${D}${sysconfdir}/init.d/monit
	sed -i 's:# set daemon  120:set daemon  120:' ${S}/monitrc
	sed -i 's:include /etc/monit.d/:include /${sysconfdir}/monit.d/:' ${S}/monitrc
	install -m 600 ${S}/monitrc ${D}${sysconfdir}/monitrc
	install -m 700 -d ${D}${sysconfdir}/monit.d/
}

CONFFILES_${PN} += "${sysconfdir}/monitrc"

	
