# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8,9,10,11} )

inherit distutils-r1

DESCRIPTION="JupyterLab Extension to share the URL to a running Jupyter Server"
HOMEPAGE="https://github.com/jupyterlab-contrib/jupyterlab-link-share"
SRC_URI="https://github.com/jupyterlab-contrib/jupyterlab-link-share/releases/download/v${PV}/${P}.tar.gz"
#DISTUTILS_USE_SETUPTOOLS="pyproject.toml"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
    >=dev-python/jupyter_packaging-0.10.0[${PYTHON_USEDEP}]
    >=dev-python/jupyterlab-3.0.0[${PYTHON_USEDEP}]
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