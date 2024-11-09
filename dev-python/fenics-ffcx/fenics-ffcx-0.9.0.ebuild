# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12,13} )

inherit cmake distutils-r1

DESCRIPTION="Next generation FEniCS Form Compiler for finite element forms"
HOMEPAGE="
	https://github.com/FEniCS/ffcx
"
SRC_URI="https://github.com/FEniCS/ffcx/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3 public-domain"
SLOT="0"
KEYWORDS="~amd64"


RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/cffi[${PYTHON_USEDEP}]
	=dev-python/fenics-basix-${PV::-2}*[${PYTHON_USEDEP}]
	=dev-python/fenics-ufl-2024.2*[${PYTHON_USEDEP}]
"

S=${WORKDIR}/ffcx-${PV}
CMAKE_USE_DIR="${S}/cmake"

src_prepare() {
	cmake_src_prepare
	distutils-r1_src_prepare
}

src_configure () {
	distutils-r1_src_prepare
	cmake_src_configure
}

src_install() {
	cmake_src_install
	distutils-r1_src_install
}
