# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic toolchain-funcs multilib-minimal

DESCRIPTION="Library that converts FORTRAN to C source"
HOMEPAGE="https://www.netlib.org/f2c/"
SRC_URI="https://web.archive.org/web/20250127132313/https://www.netlib.org/f2c/${PN}.zip -> ${P}.zip"

LICENSE="HPND"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="static-libs"

BDEPEND="app-arch/unzip"

S="${WORKDIR}"

PATCHES=(
	"${FILESDIR}"/20051004-add-ofiles-dep.patch
	"${FILESDIR}"/20090407-link-shared-libf2c-correctly.patch
	"${FILESDIR}"/${PN}-20110801-main.patch
	"${FILESDIR}"/${PN}-20110801-64bit-long.patch
	"${FILESDIR}"/${PN}-20110801-format-security.patch
	"${FILESDIR}"/${PN}-20130927-fix-buildsystem.patch
)

#src_unpack() {
#	default
# }

src_prepare() {
	default
	mkdir ${S}/src
	mv ${S}/* ${S}/src/
	export BUILD_DIR=${S}/src
	multilib_copy_sources
}

multilib_src_configure() {
	tc-export AR CC RANLIB
}

multilib_src_compile() {
	if use static-libs; then
		emake -f makefile.u all
		# Clean up files so we can recompile
		# with -fPIC for the shared lib
		rm -v *.o || die "clean failed"
	fi

	append-cflags -fPIC
	emake -f makefile.u libf2c.so
}

multilib_src_install() {
	doheader f2c.h

	dolib.so libf2c.so.2
	dosym libf2c.so.2 /usr/$(get_libdir)/libf2c.so
	use static-libs && dolib.a libf2c.a

	einstalldocs
	dodoc Notice
}
