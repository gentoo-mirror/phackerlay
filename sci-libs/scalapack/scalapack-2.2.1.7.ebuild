# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic fortran-2 toolchain-funcs

DESCRIPTION="Subset of LAPACK routines redesigned for heterogenous (MPI) computing"
HOMEPAGE="
	https://www.netlib.org/scalapack/
	https://github.com/scivision/scalapack
"
SRC_URI="
        https://github.com/scivision/scalapack/archive/refs/tags/v${PV}.tar.gz
	"
#        https://github.com/Reference-ScaLAPACK/scalapack/archive/refs/tags/v${PV}.tar.gz

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~riscv ~x86 ~amd64-linux ~x86-linux"
IUSE="static-libs test"
RESTRICT="!test? ( test )"

BDEPEND="virtual/pkgconfig"
RDEPEND="
	virtual/lapack
	virtual/mpi[fortran]
"
DEPEND="${RDEPEND}"

src_prepare() {
	cmake_src_prepare

	if use static-libs; then
		mkdir "${WORKDIR}/${PN}_static" || die
	fi
	# mpi does not have a pc file
	sed -i -e 's/mpi//' scalapack.pc.in || die
}

src_configure() {
	# -Werror=strict-aliasing
	# https://bugs.gentoo.org/862924
	# https://github.com/Reference-ScaLAPACK/scalapack/issues/95
	#
	# Do not trust it for LTO either.
	append-flags -fno-strict-aliasing -fallow-argument-mismatch
	filter-lto

	scalapack_configure() {
#			-DBLAS_LIBRARIES="$($(tc-getPKG_CONFIG) --libs blas)"
#			-DLAPACK_LIBRARIES="$($(tc-getPKG_CONFIG) --libs lapack)"
		local mycmakeargs=(
			-DUSE_OPTIMIZED_LAPACK_BLAS=ON
			-DBLA_VENDOR=OpenBLAS
			-DSCALAPACK_BUILD_TESTS=$(usex test)
			-DMPI_BASE_DIR=${EPREFIX}/usr
			$@
		)
		cmake_src_configure
	}

	scalapack_configure -DBUILD_SHARED_LIBS=ON -DBUILD_STATIC_LIBS=OFF
	use static-libs && \
		CMAKE_BUILD_DIR="${WORKDIR}/${PN}_static" scalapack_configure \
		-DBUILD_SHARED_LIBS=OFF -DBUILD_STATIC_LIBS=ON
}

src_compile() {
	cmake_src_compile
	use static-libs && \
		CMAKE_BUILD_DIR="${WORKDIR}/${PN}_static" cmake_src_compile
}

src_install() {
	cmake_src_install
	use static-libs && \
		CMAKE_BUILD_DIR="${WORKDIR}/${PN}_static" cmake_src_install

	insinto /usr/include/blacs
	doins BLACS/SRC/*.h

	insinto /usr/include/scalapack
	doins PBLAS/SRC/*.h
}
