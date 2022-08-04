# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="C++ tensors with broadcasting and lazy computing"
HOMEPAGE="https://github.com/xtensor-stack/xtensor"
SRC_URI="https://github.com/xtensor-stack/xtensor/archive/refs/tags/${PV}.tar.gz"
LICENSE="BSD-3"

SLOT="0"
KEYWORDS="~amd64"
IUSE="openmp cpu_flags_amd64_sse2"

BDEPEND="
	dev-cpp/xtl
	openmp? ( sys-devel/gcc[openmp] )
"



src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
#	OPTION(XTENSOR_USE_XSIMD "simd acceleration for xtensor" OFF)
#	OPTION(XTENSOR_USE_TBB "enable parallelization using intel TBB" OFF)
#	OPTION(XTENSOR_USE_OPENMP "enable parallelization using OpenMP" OFF)
		-DXTENSOR_USE_XSIMD=$(usex cpu_flags_amd64_sse2)
		-DXTENSOR_USE_OPENMP=$(usex openmp)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
}

src_test() {
	# override parallel mode only for tests
	local myctestargs=( "-j 1" )
	cmake_src_test
}
