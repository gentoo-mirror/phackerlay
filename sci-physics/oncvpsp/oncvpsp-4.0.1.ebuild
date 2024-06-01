# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION=""
HOMEPAGE="
	https://github.com/oncvpsp/oncvpsp
"
SRC_URI="https://github.com/oncvpsp/oncvpsp/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+blas_openblas test"

DEPEND="
	sys-devel/gcc[fortran]
	blas_openblas? ( sci-libs/openblas )
"

PATCHES=(
	${FILESDIR}/1-no-libxc.patch
	${FILESDIR}/2-fix-ref-path.patch
	${FILESDIR}/3-make-test-optional.patch
)

REQUIRED_USE="
	^^ ( blas_openblas )
"

src_configure() {
	default

	filter-lto

	MAKE_INC="${S}/make.inc"
	echo "F77        = gfortran" > $MAKE_INC
	echo "F90        = gfortran" >> $MAKE_INC
	echo "CC         = gcc" >> $MAKE_INC
	echo "FCCPP	   = cpp" >> $MAKE_INC
	echo "FLINKER     = gfortran" >> $MAKE_INC
	echo "LIBS = -lopenblas" >> $MAKE_INC
#	echo "FCCPPFLAGS = -ansi -DLIBXC_VERSION=400" >> $MAKE_INC
#	echo "OBJS_LIBXC =    exc_libxc_stub.o" >> $MAKE_INC
#	echo "LIBS += -lxcf90 -lxc" >> $MAKE_INC
#	echo "FFLAGS += -I${EPREFIX}/usr/include" >> $MAKE_INC
#	echo "OBJS_LIBXC =    functionals.o exc_libxc.o" >> $MAKE_INC
}

src_test() {
	emake -j1 test
}

src_install() {
	dobin ${S}/src/oncvpspnr.x
	dobin ${S}/src/oncvpspr.x
	dobin ${S}/src/oncvpsp.x
}
