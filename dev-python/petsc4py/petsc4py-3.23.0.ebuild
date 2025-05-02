# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12,13} )

DISTUTILS_EXT=1

inherit distutils-r1

DESCRIPTION="A suite of data structures and routines for the scalable (parallel) solution of scientific applications modeled by partial differential equations"
HOMEPAGE="https://gitlab.com/petsc/petsc"
SRC_URI="https://web.cels.anl.gov/projects/petsc/download/release-snapshots/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/mpi4py[${PYTHON_USEDEP}]
	~sci-mathematics/petsc-${PV}
	!~dev-python/cython-0.29.34[${PYTHON_USEDEP}]
"
# cython
# https://fenicsproject.discourse.group/t/error-during-python-installation-of-dolfinx/10993
