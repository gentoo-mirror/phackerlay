# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11,12} )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1 pypi

DESCRIPTION="Use MyST Markdown directly in Jupyter Lab"
HOMEPAGE="https://github.com/executablebooks/jupyterlab-myst"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

#RESTRICT="network-sandbox"

RDEPEND="
	<dev-python/jupyter-server-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/jupyter-server-2.0.0[${PYTHON_USEDEP}]
"
BDEPEND="
	>=dev-python/jupyterlab-4.0.0[${PYTHON_USEDEP}]
	<dev-python/jupyterlab-5.0.0[${PYTHON_USEDEP}]
    dev-python/hatch-nodejs-version[${PYTHON_USEDEP}]
"

S=${WORKDIR}/jupyterlab_myst-${PV}

distutils_enable_tests pytest

python_install_all() {
    mv ${D}/usr/etc ${D}
    distutils-r1_python_install_all
}
