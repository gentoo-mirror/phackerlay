# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=scikit-build-core
PYTHON_COMPAT=( python3_{12,13} )
DISTUTILS_EXT=1

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
	>=dev-python/nanobind-2.0.0[${PYTHON_USEDEP}]
        dev-python/fenics-ufl[${PYTHON_USEDEP}]
        dev-python/numpy[${PYTHON_USEDEP}]
        dev-python/mpi4py[${PYTHON_USEDEP}]
        dev-python/petsc4py[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

src_unpack() {
	default
	S=${WORKDIR}/${P}/python
}
