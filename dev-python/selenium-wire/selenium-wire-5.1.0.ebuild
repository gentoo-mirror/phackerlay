# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9,10,11} )
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="Extends Selenium to give you the ability to inspect requests made by the browser."
HOMEPAGE="https://github.com/wkeeling/selenium-wire"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/blinker-1.4[${PYTHON_USEDEP}]
	>=dev-python/brotli-1.0.9[${PYTHON_USEDEP}]
	>=dev-python/certifi-2019.9.11[${PYTHON_USEDEP}]
	>=dev-python/h2-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/hyperframe-6.0.0[${PYTHON_USEDEP}]
	>=dev-python/kaitaistruct-0.7[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-0.3.1[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-22.0.0[${PYTHON_USEDEP}]
	>=dev-python/pyparsing-2.4.2[${PYTHON_USEDEP}]
	>=dev-python/PySocks-1.7.1[${PYTHON_USEDEP}]
	>=dev-python/selenium-4.0.0[${PYTHON_USEDEP}]
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
