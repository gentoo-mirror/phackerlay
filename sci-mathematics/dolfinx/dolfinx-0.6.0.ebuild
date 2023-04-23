# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1 cmake

DESCRIPTION="Next generation FEniCS problem solving environment"
HOMEPAGE="
	https://github.com/FEniCS/dolfinx
"
SRC_URI="https://github.com/FEniCS/dolfinx/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
        dev-python/fenics-basix[${PYTHON_USEDEP}]
        dev-python/fenics-ffcx[${PYTHON_USEDEP}]
"

BDEPEND="
	dev-python/pybind11[${PYTHON_USEDEP}]
        dev-python/fenics-ufl[${PYTHON_USEDEP}]
        dev-python/numpy[${PYTHON_USEDEP}]
        dev-python/mpi4py[${PYTHON_USEDEP}]
        dev-python/petsc4py[${PYTHON_USEDEP}]
"

PYTHON_S=${WORKDIR}/${P}/python
CPP_S=${WORKDIR}/${P}/cpp

src_prepare() {
	S=$CPP_S
	cd ${S}
        cmake_src_prepare
	S=$PYTHON_S
	cd ${S}
        distutils-r1_src_prepare
}

src_compile() {
        cmake_src_compile
        distutils-r1_src_compile
}

src_install() {
#        cmake_src_install
        distutils-r1_src_install
}

python_install() {
        distutils-r1_python_install --skip-build
}

python_install_all() {
        distutils-r1_python_install_all
}
