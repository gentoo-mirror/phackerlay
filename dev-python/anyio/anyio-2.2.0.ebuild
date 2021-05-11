# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )

inherit distutils-r1

DESCRIPTION="High level compatibility layer for multiple asynchronous event loop implementations"
HOMEPAGE="https://github.com/agronholm/anyio"
SRC_URI="https://files.pythonhosted.org/packages/db/7c/c25052956b882c226adcad815197f32dde4eb9dfbbd19041b291811b1032/anyio-2.0.2.tar.gz -> ${P}.tar.gz"
#SRC_URI="https://github.com/agronholm/anyio/archive/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
    >=dev-python/idna-2.8[${PYTHON_USEDEP}]
    >=dev-python/sniffio-1.1[${PYTHON_USEDEP}]
	"

src_unpack() {
	default
	mv * ${P}
}

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
