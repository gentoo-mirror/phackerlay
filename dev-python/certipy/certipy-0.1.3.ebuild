# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11} )

inherit distutils-r1

DESCRIPTION="A simple python tool for creating certificate authorities and certificates on the fly."
HOMEPAGE="https://github.com/LLNL/certipy"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="\
	dev-python/jupyterhub[${PYTHON_USEDEP}] \
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
