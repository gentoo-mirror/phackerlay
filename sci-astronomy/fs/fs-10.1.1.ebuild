# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="MarkIV Field System"
HOMEPAGE="https://github.com/nvi-inc/fs"
SRC_URI="https://github.com/nvi-inc/fs/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="10.1"
KEYWORDS="~amd64"

IUSE="+strip-sources doc"

PATCHES=(
	"${FILESDIR}"/10/01_remove_third_party_tools_bundled.patch
	"${FILESDIR}"/10/03_glib_stime.patch
	"${FILESDIR}"/10/02_version_detection.patch
	"${FILESDIR}"/10/04_rdtcn_libm_miss.patch
	)

BDEPEND="
	sys-devel/gcc:9.5.0
	dev-lang/fort77
	sys-devel/bison
"

DEPEND="
	sys-libs/ncurses[tinfo]
	sys-libs/gpm
	net-libs/libnsl
	net-libs/libtirpc
	sys-libs/readline
	dev-libs/libf2c
	=dev-libs/nng-1.3.2
	=dev-libs/jansson-2*
	acct-group/oper
	acct-group/prog
	acct-user/oper
	acct-user/prog
"

src_prepare () {
	if test $(gcc-major-version) -ne 9; then
		eerror
		eerror	Please switch to gcc-9
		eerror
		die
	fi
	default
}

src_compile () {
	export FC=fort77
	export FS_TINFO_LIB=1
	export MAKEOPTS="-j1" # should not be parallel, unhandled race conditions
	default
	make clean
	make rmdoto
}

src_install () {
	if use strip-sources; then
		find ${S} -type f -name '*.c' -exec rm '{}' \;
		find ${S} -type f -name '*.f' -exec rm '{}' \;
		find ${S} -type f -name '*.cpp' -exec rm '{}' \;
                find ${S} -type f -name 'makefile*' -exec rm '{}' \;
                find ${S} -type f -name 'Makefile*' -exec rm '{}' \;
                find ${S} -type f -name '*.h' -exec rm '{}' \;
	fi
	mkdir ${D}/usr2
        if ! use doc; then
                rm ${S}/help -r
        fi
	cp -r ${S}/../${P} ${D}/usr2/
	elog
	elog	Compiled ${P} has been put to /usr2/${P},
	elog	prog and oper users have been created. If you\'d
	elog	like to have it properly installed, close
	elog	your eyes, cd /usr/${P} and make install as
	elog	root.
	elog
}
