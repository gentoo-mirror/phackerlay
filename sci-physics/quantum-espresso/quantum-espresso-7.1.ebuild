# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Suite for first-principles electronic-structure calculations and materials modeling"
HOMEPAGE="https://www.quantum-espresso.org/"

CMAKE_MAKEFILE_GENERATOR=emake

inherit cmake

SRC_URI="https://gitlab.com/QEF/q-e/-/archive/qe-${PV}/q-e-qe-${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/q-e-qe-${PV}"
KEYWORDS="~amd64"

LICENSE="GPL-2"
SLOT="0"
IUSE="+system-blas +system-fftw +system-lapack +libxc hdf5 openmp mpi elpa scalapack"

RESTRICT="network-sandbox"

RDEPEND="
	system-blas? ( virtual/blas[eselect-ldso] )
	system-lapack? ( virtual/lapack[eselect-ldso] )
	system-fftw? ( sci-libs/fftw[fortran] )
	mpi? ( virtual/mpi[fortran,threads] system-fftw? ( sci-libs/fftw[mpi] ) )
	scalapack? ( sci-libs/scalapack )
	hdf5? ( sci-libs/hdf5[fortran] )
	openmp? ( sys-devel/gcc[openmp] system-fftw? ( sci-libs/fftw[openmp] ) )
	libxc? ( >=sci-libs/libxc-5.1.2 ) 
	elpa? ( sci-libs/elpa openmp? ( sci-libs/elpa[openmp] ) mpi? ( sci-libs/elpa[mpi] ) )
"

DEPEND="${RDEPEND} \
	sys-devel/gcc[fortran]
"
BDEPEND=""

src_configure() {
        local mycmakeargs=(
                -DQE_ENABLE_LIBXC="$(usex libxc)"
                -DQE_ENABLE_MPI="$(usex mpi)"
                -DQE_ENABLE_OPENMP="$(usex openmp)"
                -DQE_ENABLE_HDF5="$(usex hdf5)"
                -DQE_ENABLE_ELPA="$(usex elpa)"
                -DQE_ENABLE_SCALAPACK="$(usex scalapack)"
        )
	# cmake -LA | awk '{if(f)print} /-- Cache values/{f=1}'
        cmake_src_configure
}

src_install() {
	cmake_src_install
	dolib.so ${BUILD_DIR}/external/mbd/src/libmbd.so
	dolib.so ${BUILD_DIR}/QEHeat/libqe_qeheat.so
	dolib.so ${BUILD_DIR}/KCW/PP/libqe_kcwpp.so
}

pkg_postinst () {
	if ! has_version sci-libs/pslibrary;
		then
		elog
		elog "If pseudo-potentials are needed"
		elog "you can merge =sci-libs/pslibrary-9999"
		elog
	fi
}
