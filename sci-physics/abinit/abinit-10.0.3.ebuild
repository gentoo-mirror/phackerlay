# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A software suite to calculate the optical, mechanical, vibrational, and other observable properties of materials"
HOMEPAGE="
	https://www.abinit.org
"
SRC_URI="https://github.com/abinit/abinit/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="mpi openmp fftw scalapack elpa"

DEPEND="
	sci-libs/netcdf-cxx
	sci-libs/netcdf-fortran
        fftw? ( sci-libs/fftw )
        mpi? ( virtual/mpi )
        scalapack? ( sci-libs/scalapack )
        elpa? ( || ( =sci-libs/elpa-2019.11.001 ) )
"

pkg_pretend() {
        use openmp && ( tc-check-openmp || die )
}

src_configure() {
	${S}/config/scripts/make-cppopts-dumper || die
        local mycmakeargs=(
		-DCMAKE_DISABLE_FIND_PACKAGE_MPI="$(usex mpi NO YES)"
		-DCMAKE_DISABLE_FIND_PACKAGE_OPENMP="$(usex openmp NO YES)"
		-DCMAKE_DISABLE_FIND_PACKAGE_FFTW="$(usex fftw NO YES)"
                -DABINIT_SCALAPACK_ENABLED="$(usex scalapack)"
                -DABINIT_ELPA_ENABLED="$(usex elpa)"
        )
        cmake_src_configure
}
