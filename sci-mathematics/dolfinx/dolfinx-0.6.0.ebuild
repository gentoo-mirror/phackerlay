# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..10} )
# 3.11 in next realease

inherit distutils-r1

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
	=sci-libs/dolfinx-${PV}
	dev-python/pybind11[${PYTHON_USEDEP}]
        dev-python/fenics-ufl[${PYTHON_USEDEP}]
        dev-python/numpy[${PYTHON_USEDEP}]
        dev-python/mpi4py[${PYTHON_USEDEP}]
        dev-python/petsc4py[${PYTHON_USEDEP}]
"

src_unpack() {
	default
	S=${WORKDIR}/${P}/python
}
