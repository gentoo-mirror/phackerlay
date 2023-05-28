# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8,9,10,11} )

inherit distutils-r1 pypi

MY_PN="remote_ikernel"
DESCRIPTION="Launch Jupyter kernels on remote systems and through batch queues so that they can be used within a local Jupyter noteboook"
HOMEPAGE="https://github.com/tdaff/remote_ikernel"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pexpect[${PYTHON_USEDEP}]
	dev-python/notebook[${PYTHON_USEDEP}]
	dev-python/tornado
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
