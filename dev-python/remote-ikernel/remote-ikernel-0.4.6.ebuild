# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9} )

inherit distutils-r1

MY_PN="remote_ikernel"
DESCRIPTION="Launch Jupyter kernels on remote systems and through batch queues so that they can be used within a local Jupyter noteboook"
HOMEPAGE="https://https://bitbucket.org/tdaff/remote_ikernel"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pexpect
	dev-python/notebook
	www-servers/tornado
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
