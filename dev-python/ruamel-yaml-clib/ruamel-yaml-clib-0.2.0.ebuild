# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="C based reader/scanner and emitter for ruamel.yaml"
HOMEPAGE="https://sourceforge.net/projects/ruamel-yaml-clib/"
SRC_URI="mirror://pypi/ruamel/ruamel.yaml.clib/ruamel.yaml.clib-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="\
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
	export RUAMEL_NO_PIP_INSTALL_CHECK=1
	distutils-r1_python_install --skip-build
}

python_install_all() {
	distutils-r1_python_install_all
}
