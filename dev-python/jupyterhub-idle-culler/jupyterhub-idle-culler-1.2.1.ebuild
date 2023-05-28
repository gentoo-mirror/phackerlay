# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{8,9,10,11} )

inherit distutils-r1 pypi

DESCRIPTION="JupyterHub service to cull idle servers and users"
HOMEPAGE="https://github.com/jupyterhub/jupyterhub-idle-culler"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/tornado
	dev-python/python-dateutil
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
