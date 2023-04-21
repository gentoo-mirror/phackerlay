# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="Grammar of Graphics Scales for bqplot"
HOMEPAGE="
	https://github.com/bqplot/bqscales
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 hppa ~ia64 ~loong ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux"

RDEPEND="
	>=dev-python/ipywidgets-8[${PYTHON_USEDEP}]
	<dev-python/ipywidgets-9[${PYTHON_USEDEP}]
	>=dev-python/traitlets-4.3.0[${PYTHON_USEDEP}]
	>=dev-python/traittypes-0.0.6[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.10.4[${PYTHON_USEDEP}]
	<dev-python/numpy-2.0.0[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

python_install() {
        distutils-r1_python_install --skip-build
        mkdir -p ${D}/etc
        mv ${D}/usr/etc/* ${D}/etc/
}
