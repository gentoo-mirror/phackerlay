# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Suite for first-principles electronic-structure calculations and materials modeling"
HOMEPAGE="https://www.quantum-espresso.org/"

inherit autotools

SRC_URI="https://gitlab.com/QEF/q-e/-/archive/qe-${PV}/q-e-qe-${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/q-e-qe-${PV}"
KEYWORDS="~amd64"

LICENSE="GPL-2"
SLOT="0"
IUSE="+system-openblas +system-fftw +xc +hdf5 +openmp mpi elpa scalapack mkl"

RDEPEND="
	system-openblas? ( sci-libs/openblas )
	system-fftw? ( sci-libs/fftw[fortran] )
	mkl? ( sci-libs/mkl-rt )
	mpi? ( virtual/mpi[fortran,threads] )
	scalapack? ( sci-libs/scalapack )
	hdf5? ( sci-libs/hdf5[fortran] )
	openmp? ( sys-devel/gcc[openmp] system-fftw? ( sci-libs/fftw[openmp] ) )
	xc? ( >sci-libs/libxc-4.0.0 system-fftw? ( sci-libs/libxc ) )
	elpa? ( =sci-libs/elpa-2016.11.001 openmp? ( sci-libs/elpa[openmp] ) )
"

DEPEND="${RDEPEND} \
	sys-devel/gcc[fortran]
"
BDEPEND=""

src_unpack() {
	if has_version dev-util/nvidia-cuda-toolkit | dev-util/nvidia-cuda-sdk;
		then
		elog
		elog "I sense CUDA is merged."
		elog "Possibly, you would be intereted in"
		elog "merging sci-physics/quantum-espresso-gpu instead"
		elog
	fi
	default
}

src_configure() {
    if ! use system-openblas
        then
        lapackinc=--with-netlib
    fi
    if ! use scalapack;
        then
        export SCALAPACK_LIBS=" "
    fi
    if ! use mpi;
        then
        export MPI_LIBS=" "
    fi
	if use elpa;
		then
		elpainc='--with-elpa-include=/usr/include/elpa_openmp-2016.11.001.pre/modules --with-elpa-lib="-lelpa_openmp" --with-elpa-version=2016'
	else
		elpainc=''
	fi
	if use hdf5;
		then
		hdf5inc='--with-hdf5=/usr'
	else
		hdf5inc=''
	fi
	if use openmp;
		then
		sed -e "s:ac_lib -lm:ac_lib -lm -lfftw3:g" -i install/configure || die
	fi
	./configure --prefix ${D} \
		$(use_enable openmp) \
		$(use_with scalapack) \
		$(use_with xc libxc) \
		$hdf5inc \
		$lapackinc \
		$elpainc || die
	if ! use scalapack;
		then
		sed -e 's:SCALAPACK_LIBS = :# SCALAPACK_LIBS = :g' -i make.inc || die
	fi
	if ! use system-fftw;
	then
		sed -e 's:FFT_LIBS     :# FFT_LIBS     :g' -i make.inc || die
		sed -e 's:__FFTW3:__FFTW:g' -i make.inc || die
	fi
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
	make ${MAKEOPTS} tddfpt || die
	make ${MAKEOPTS} hp || die
	make ${MAKEOPTS} xspectra || die
	make ${MAKEOPTS} gwl || die
}

src_install() {
    make -j1 install
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
