# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="UFL - FEniCS project's Unified Form Language"
HOMEPAGE="
	https://github.com/FEniCS/ufl
"
SRC_URI="https://github.com/FEniCS/ufl/archive/refs/tags/${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

S=${WORKDIR}/ufl-${PV}

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
"
BDEPEND="
	>=dev-python/setuptools-58[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
"

