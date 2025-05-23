# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1 pypi linux-info

DESCRIPTION="Control utility for Korad / Tenma power supplies "
HOMEPAGE="https://github.com/attie/koradctl"
#SRC_URI="https://github.com/attie/koradctl/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
    dev-python/pyserial[${PYTHON_USEDEP}]
	"

#distutils_enable_tests pytest

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

pkg_setup() {
	CONFIG_CHECK="~USB_ACM"
	linux-info_pkg_setup
}

pkg_postinst() {
	elog
	elog Please add all relevant users to the dialout group
	elog
}
