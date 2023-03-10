# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1 cmake

DESCRIPTION="FEniCS finite element basis evaluation library"
HOMEPAGE="
	https://github.com/FEniCS/basix
"
SRC_URI="https://github.com/FEniCS/basix/archive/refs/tags/v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pybind11[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-util/ninja
	>=dev-util/cmake-3.16
	>=dev-python/setuptools-42[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
	>=dev-python/scikit-build-0.12[${PYTHON_USEDEP}]
	>=dev-python/pybind11-2.6.4[${PYTHON_USEDEP}]
"

