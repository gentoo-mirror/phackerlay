# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11} )

inherit distutils-r1 pypi

DESCRIPTION="A set of widgets to help facilitate reuse of large datasets across widgets"
HOMEPAGE="https://github.com/vidartf/ipydatawidgets"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/ipywidgets-7.0.0[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	>=dev-python/traittypes-0.2.0[${PYTHON_USEDEP}]
"

src_prepare() {
	distutils-r1_src_prepare
}

python_compile() {
	distutils-r1_python_compile
}

python_install() {
	distutils-r1_python_install --skip-build
	rm ${D}/usr/share/jupyter/lab/extensions/jupyter-datawidgets-*.tgz
}

python_install_all() {
	distutils-r1_python_install_all
}
