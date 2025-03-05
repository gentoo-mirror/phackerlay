# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11,12} )
DISTUTILS_USE_PEP517="hatchling"
inherit distutils-r1

DESCRIPTION="Matplotlib Jupyter Extension"
HOMEPAGE="https://github.com/matplotlib/ipympl"
SRC_URI="https://github.com/matplotlib/ipympl/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="network-sandbox"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	<dev-python/ipython-9[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	>=dev-python/ipywidgets-7.6.0[${PYTHON_USEDEP}]
	<dev-python/ipywidgets-9.0.0[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-3.4.0[${PYTHON_USEDEP}]
	<dev-python/matplotlib-4.0.0[${PYTHON_USEDEP}]
	sys-apps/yarn
"

S="${WORKDIR}/${PN}-tags-${PV}"

addpredict /usr/etc

python_install_all() {
	distutils-r1_python_install_all
	mv "${ED}/usr/etc" "${ED}/etc" || die
}
