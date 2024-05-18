# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="A software suite to calculate the optical, mechanical, vibrational, and other observable properties of materials"
HOMEPAGE="
	https://www.abinit.org
"
SRC_URI="https://github.com/abinit/abinit/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="blas_openblas mpi openmp fftw scalapack elpa wannier90"

DEPEND="
	sci-libs/netcdf-cxx
	sci-libs/netcdf-fortran
        blas_openblas? ( sci-libs/openblas )
        fftw? ( sci-libs/fftw )
        mpi? ( virtual/mpi[romio] )
        scalapack? ( sci-libs/scalapack )
        elpa? ( || ( =sci-libs/elpa-2019.11.001 ) )
	wannier90? ( sci-libs/wannier90 )
"

PATCHES=(
	${FILESDIR}/v10-scalapack-miss.patch
)

pkg_pretend() {
        use openmp && ( tc-check-openmp || die )
}

src_prepare() {
	sed -e "s:9.11.0:${PV}:g" -i ${WORKDIR}/${P}/CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	append-fflags -fallow-argument-mismatch
	filter-lto

	${S}/config/scripts/make-cppopts-dumper || die
        local mycmakeargs=(
		-DCMAKE_DISABLE_FIND_PACKAGE_MPI="$(usex mpi NO YES)"
		-DCMAKE_DISABLE_FIND_PACKAGE_OpenMP="$(usex openmp NO YES)"
		-DABINIT_FFT_FLAVOR="$(usex fftw FFTW3 GOEDECKER)"
                -DABINIT_SCALAPACK_ENABLED="$(usex scalapack)"
                -DABINIT_ELPA_ENABLED="$(usesx elpa)"
		-DCMAKE_DISABLE_FIND_PACKAGE_MPI="$(usex mpi NO YES)"
		-DABINIT_ENABLE_MPI_IO="$(usex mpi YES NO)"
		-DBLA_VENDOR=openblas
		-DWANNIER90_WANTED="$(usex wannier90 YES NO)"
		-DABINIT_WANNIER90_BUILD=NO
        )
        cmake_src_configure
}
