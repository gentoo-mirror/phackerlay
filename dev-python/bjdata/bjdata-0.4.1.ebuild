# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1

DESCRIPTION="Binary JSON (BJData/UBJSON) Support for Python"
HOMEPAGE="
	https://github.com/NeuroJSON/pybj
"
SRC_URI="https://github.com/NeuroJSON/pybj/archive/refs/tags/v${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	>=dev-python/numpy-1.8.0[${PYTHON_USEDEP}]
"

S=${WORKDIR}/pybj-${PV}
