# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1

DESCRIPTION="The backend—i.e. core services, APIs, and REST endpoints—to Jupyter web applications"
HOMEPAGE="https://github.com/jupyter-server/jupyter_server"
SRC_URI="https://github.com/jupyter-server/jupyter_server/archive/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/jinja[${PYTHON_USEDEP}]
	>=www-servers/tornado-6.1[${PYTHON_USEDEP}]
	>=dev-python/pyzmq-17[${PYTHON_USEDEP}]
	dev-python/ipython_genutils[${PYTHON_USEDEP}]
	>=dev-python/traitlets-4.2.1[${PYTHON_USEDEP}]
	>=dev-python/jupyter_core-4.4.0[${PYTHON_USEDEP}]
	>=dev-python/jupyter_client-6.1.1[${PYTHON_USEDEP}]
	dev-python/nbformat[${PYTHON_USEDEP}]
	dev-python/nbconvert[${PYTHON_USEDEP}]
	dev-python/send2trash[${PYTHON_USEDEP}]
	>=dev-python/terminado-0.8.3[${PYTHON_USEDEP}]
	dev-python/prometheus_client[${PYTHON_USEDEP}]
	>=dev-python/anyio-2.0.2[${PYTHON_USEDEP}]
	<dev-python/anyio-3[${PYTHON_USEDEP}]
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
