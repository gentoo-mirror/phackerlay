# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11,12} )

inherit distutils-r1 pypi

DESCRIPTION="non-blocking redis client for python twisted"
HOMEPAGE="https://github.com/IlyaSkriblovsky/txredisapi"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
    dev-python/twisted[${PYTHON_USEDEP}]
    dev-python/six[${PYTHON_USEDEP}]
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
