# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )
DISTUTILS_EXT=1

inherit distutils-r1 cmake

DESCRIPTION="FEniCS finite element basis evaluation library"
HOMEPAGE="
	https://github.com/FEniCS/basix
"
SRC_URI="https://github.com/FEniCS/basix/archive/refs/tags/v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests pytest

S=${WORKDIR}/basix-${PV}

RDEPEND="
	dev-python/pybind11[${PYTHON_USEDEP}]
"
BDEPEND="
	>=dev-python/scikit-build-0.12[${PYTHON_USEDEP}]
	>=dev-python/pybind11-2.6.4[${PYTHON_USEDEP}]
"

src_prepare() {
        cmake_src_prepare
        distutils-r1_src_prepare
}

src_compile() {
	cmake_src_compile
	distutils-r1_src_compile
}

src_install() {
	cmake_src_install
	distutils-r1_src_install
}

python_install() {
        distutils-r1_python_install --skip-build
}

python_install_all() {
        distutils-r1_python_install_all
}


