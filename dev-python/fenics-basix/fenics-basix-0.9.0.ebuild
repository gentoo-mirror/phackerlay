# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=scikit-build-core
PYTHON_COMPAT=( python3_{12,13} )
DISTUTILS_EXT=1

inherit distutils-r1

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
	>=dev-python/numpy-1.21[${PYTHON_USEDEP}]
"
BDEPEND="
	>=dev-python/nanobind-2.0.0[${PYTHON_USEDEP}]
"


