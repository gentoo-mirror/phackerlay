# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1 cmake

DESCRIPTION="Next generation FEniCS problem solving environment "
HOMEPAGE="
	https://github.com/FEniCS/dolphinx
"
SRC_URI="https://github.com/FEniCS/dolphinx/archive/refs/tags/v${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	sci-mathematics/petsc[boost,hdf5,metis,scotch,mpi]
        dev-libs/pugixml
        dev-python/fenics-ffcx[${PYTHON_USEDEP}]
        dev-python/fenics-basix[${PYTHON_USEDEP}]
"

RDEPEND="
	dev-python/pybind11[${PYTHON_USEDEP}]
        dev-python/fenics-ufl[${PYTHON_USEDEP}]
        dev-python/numpy[${PYTHON_USEDEP}]
        dev-python/mpi4py[${PYTHON_USEDEP}]
        dev-python/petsc4py[${PYTHON_USEDEP}]
"
