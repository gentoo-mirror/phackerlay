# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_9 python3_10 python3_11 )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1

DESCRIPTION="A Jupyter Server Extension Providing Support for Terminals"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
HOMEPAGE="https://github.com/jupyter-server/jupyter_server_terminals"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""
RDEPEND="
	>=dev-python/terminado-0.8.3
"

distutils_enable_tests pytest

python_install_all() {
        distutils-r1_python_install_all
	mv ${D}/usr/etc ${D}/
}
