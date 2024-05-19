# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Package for generating maximally-localized Wannier functions"
HOMEPAGE="https://wannier.org"

SRC_URI="https://github.com/wannier-developers/wannier90/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="GPL-2"
IUSE="+blas_openblas mpi"
SLOT="0"

DEPEND="
	blas_openblas? ( sci-libs/openblas )
"

BDEPEND="
        mpi? ( virtual/mpi )
	!mpi? ( sys-devel/gcc[fortran] )
"

REQUIRED_USE="
	^^ ( blas_openblas )
"

src_configure() {
        filter-lto

	echo "F90 = gfortran" >> ${S}/make.inc
	if use mpi; then
		echo "COMMS = mpi" >> ${S}/make.inc
		echo "MPIF90 = mpif90" >> ${S}/make.inc
		echo "FCOPTS = -fallow-argument-mismatch" >> ${S}/make.inc
	fi
	use blas_openblas && echo "LIBS = -lopenblas" >> ${S}/make.inc
}

src_compile() {
	emake default lib
}

src_install() {
	emake PREFIX="${EPREFIX}/usr" DESTDIR="${D}" install
}
