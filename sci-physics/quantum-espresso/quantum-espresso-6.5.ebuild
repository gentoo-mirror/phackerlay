# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Suite for first-principles electronic-structure calculations and materials modeling"
HOMEPAGE="https://www.quantum-espresso.org/"

inherit autotools git-r3

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/QEF/q-e.git"
	EGIT_BRANCH="master"
	KEYWORDS=""
else
	SRC_URI="https://gitlab.com/QEF/q-e/-/archive/qe-${PV}/q-e-qe-${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/q-e-qe-${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="+system-blas +system-lapack +fftw +xc +hdf5 +openmp mpi elpa scalapack"

RDEPEND="
	system-blas? ( virtual/blas )
	system-lapack? ( virtual/lapack )
	fftw? ( sci-libs/fftw[fortran] )
	mpi? ( virtual/mpi[fortran,threads] )
	scalapack? ( sci-libs/scalapack )
	hdf5? ( sci-libs/hdf5[fortran] )
	openmp? ( sys-devel/gcc[openmp] fftw? ( sci-libs/fftw[openmp] ) )
	xc? ( >sci-libs/libxc-4.0.0 fftw? ( sci-libs/libxc ) )
	elpa? ( =sci-libs/elpa-2016.11.001 openmp? ( sci-libs/elpa[openmp] ) )
"
DEPEND="${RDEPEND} \
	sys-devel/gcc[fortran]
"
BDEPEND=""

src_unpack() {
	default
}

src_configure() {
	if use elpa;
		then
		elpainc='--with-elpa-include=/usr/include/elpa_openmp-2016.11.001.pre/modules --with-elpa-lib="-lelpa_openmp" --with-elpa-version=2016'
	else
		elpainc=''
	fi
	if use openmp;
		then
		sed -e "s:ac_lib -lm:ac_lib -lm -lfftw3:g" -i install/configure || die
	fi
	./configure --prefix ${D} \
		$(use_enable mpi parallel) \
		$(use_enable openmp) \
		$(use_with hdf5 hdf5=/usr) \
		$(use_with scalapack) \
		$(use_with xc libxc) \
		$elpainc || die
	if use xc;
		then
		sed -e "s:-lxcf90:-lxcf90 -lxcf03:g" -i make.inc || die
	fi
	if use openmp;
		then
		sed -e "s:-lfftw3_omp:-lfftw3_omp -lfftw3:g" -i make.inc || die
		sed -e "s:-lFoX_fsys:-lFoX_fsys -fopenmp:g" -i make.inc || die
	fi
	}

src_compile() {
	make ${MAKEOPTS} pwall || die
	make ${MAKEOPTS} cp || die
	make ${MAKEOPTS} ld1 || die
	make ${MAKEOPTS} upf || die
	make ${MAKEOPTS} tddfpt || die
	make ${MAKEOPTS} hp || die
	make ${MAKEOPTS} xspectra || die
	make ${MAKEOPTS} gwl || die
}


pkg_postinst () {
    elog
	elog "If pseudo-potentials are needed"
	elog "you can install =sci-physics/pslibrary-9999"
    elog
}
