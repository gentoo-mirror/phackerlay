# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MULTILIB_COMPAT=( abi_x86_32 )

inherit toolchain-funcs multilib-minimal

DESCRIPTION="MarkIV Field System"
HOMEPAGE="https://github.com/nvi-inc/fs"
SRC_URI="https://github.com/nvi-inc/fs/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="9.13"
KEYWORDS="~amd64"

IUSE="+strip-sources +abi_x86_32 doc"

PATCHES=(
	"${FILESDIR}"/9/01_makefile.patch
	"${FILESDIR}"/9/02_glib_stime.patch
	)

BDEPEND="
	=sys-devel/gcc-9*
	dev-lang/fort77
        sys-devel/bison
"

DEPEND="
	sys-libs/ncurses[tinfo,${MULTILIB_USEDEP}]
	sys-libs/gpm[${MULTILIB_USEDEP}]
	net-libs/libnsl[${MULTILIB_USEDEP}]
	net-libs/libtirpc[${MULTILIB_USEDEP}]
	sys-libs/readline[${MULTILIB_USEDEP}]
	dev-libs/libf2c[${MULTILIB_USEDEP}]
	=dev-libs/nng-1.3.2[${MULTILIB_USEDEP}]
	=dev-libs/jansson-2*[${MULTILIB_USEDEP}]
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
	mkdir ${S}/bin
	find ${S} -type f \( -name makefile -o -name Makefile \) \
		-exec sed -i 's:gcc :\$(CC) \$(CFLAGS) :g' '{}' \;
	find ${S} -type f \( -name makefile -o -name Makefile \) \
		-exec sed -i 's:cc :\$(CC) \$(CFLAGS) :g' '{}' \;
	find ${S}/rclco -type f \( -name makefile -o -name Makefile \) \
		-exec sed -i 's:CC= gcc::g' '{}' \;
	find ${S}/vex -type f \( -name makefile -o -name Makefile \) \
		-exec sed -i 's:CC=gcc::g' '{}' \;
	if ! use doc; then
		rm ${S}/help -r
	fi
	multilib_copy_sources
}

multilib_src_configure () {
	tc-export AR CC RANLIB
	export FS_TINFO_LIB=1
}

multilib_src_compile () {
	export FC="fort77 -m32"
	export F77="fort77 -m32" # should be defined here, otherwise is overwritten by gfortran
        export MAKEOPTS="-j1" # should not be parallel, unhandled race conditions
        default
	make clean
	make rmdoto
}

multilib_src_install () {
	if use strip-sources; then
		find ${WORKDIR} -type f -name '*.c*' -exec rm '{}' \;
		find ${WORKDIR} -type f -name '*.f*' -exec rm '{}' \;
		find ${WORKDIR} -type f -name 'makefile*' -exec rm '{}' \;
		find ${WORKDIR} -type f -name 'Makefile*' -exec rm '{}' \;
		find ${WORKDIR} -type f -name '*.h' -exec rm '{}' \;
	fi
        if ! use doc; then
                find ${WORKDIR} -type d -name help -exec rm '{}' -r \;
        fi
	mkdir -p ${D}/usr2/${P}
	cp -r ${WORKDIR}/${P}-abi_x86_32.x86/* ${D}/usr2/${P}/
	elog
	elog	Compiled ${P} has been put to /usr2/${P},
	elog	prog and oper users have been created. If you\'d
	elog	like to have it properly installed, close
	elog	your eyes, cd /usr/${P} and make install as
	elog	root.
	elog
}
