# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11} )

inherit distutils-r1

DESCRIPTION="A suite of data structures and routines for the scalable (parallel) solution of scientific applications modeled by partial differential equations"
HOMEPAGE="https://gitlab.com/petsc/petsc"

SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/mpi4py[${PYTHON_USEDEP}]
	sci-mathematics/petsc
"
