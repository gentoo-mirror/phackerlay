# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9,10,11} )

inherit distutils-r1

DESCRIPTION="Matplotlib Jupyter Extension"
HOMEPAGE="https://github.com/matplotlib/ipympl"
SRC_URI="https://github.com/matplotlib/ipympl/archive/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="network-sandbox"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	<dev-python/ipython-9[${PYTHON_USEDEP}]
	dev-python/ipython_genutils[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	>=dev-python/ipywidgets-7.6.0[${PYTHON_USEDEP}]
	<dev-python/ipywidgets-9.0.0[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-3.4.0[${PYTHON_USEDEP}]
	<dev-python/matplotlib-4.0.0[${PYTHON_USEDEP}]
	sys-apps/yarn
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
