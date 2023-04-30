# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11} )

inherit distutils-r1

DESCRIPTION="Python bindings for libosmium"
HOMEPAGE="https://github.com/osmcode/pyosmium"

SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=sci-libs/osmium-2.16.0
	>=dev-python/pybind-2.2[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"

