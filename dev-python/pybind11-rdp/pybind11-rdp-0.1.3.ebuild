# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11} )

inherit distutils-r1

DESCRIPTION="C++ implementation of the Ramer-Douglas-Peucker algorithm"
HOMEPAGE="https://github.com/cubao/pybind11-rdp"

SRC_URI="mirror://pypi/${PN:0:1}/pybind11_rdp/pybind11_rdp-${PV}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pybind
"

S=${WORKDIR}/pybind11_rdp-${PV}
