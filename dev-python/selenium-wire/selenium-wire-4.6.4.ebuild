# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9} )

inherit distutils-r1

DESCRIPTION="Extends Selenium to give you the ability to inspect requests made by the browser."
HOMEPAGE="https://github.com/wkeeling/selenium-wire"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/blinker-1.4[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	>=dev-python/h2-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/hyperframe-6.0.0[${PYTHON_USEDEP}]
	>=dev-python/kaitaistruct-0.7[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-0.3.1[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-19.1.0[${PYTHON_USEDEP}]
	>=dev-python/pyparsing-2.4.2[${PYTHON_USEDEP}]
	>=dev-python/PySocks-1.7.1[${PYTHON_USEDEP}]
	>=dev-python/selenium-3.4.0[${PYTHON_USEDEP}]
	dev-python/werkzeug[${PYTHON_USEDEP}]
	>=dev-python/wsproto-0.14[${PYTHON_USEDEP}]
	>=dev-python/zstandart-0.14.1[${PYTHON_USEDEP}]
"

src_prepare() {
	distutils-r1_src_prepare
}

python_compile() {
	distutils-r1_python_compile
}

python_install() {
	distutils-r1_python_install --skip-build
}

python_install_all() {
	distutils-r1_python_install_all
}
