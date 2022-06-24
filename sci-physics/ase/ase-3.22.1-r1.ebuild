# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{8,9,10,11} )

inherit distutils-r1

DESCRIPTION="A set of tools and Python modules for setting up, manipulating, running, visualizing and analyzing atomistic simulations"
HOMEPAGE="https://wiki.fysik.dtu.dk/ase/ https://pypi.org/project/ase/"
SRC_URI="https://pypi.org/packages/source/a/ase/ase-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+visualize"

PYTHON_REQ_USE="visualize? (tk)"

RDEPEND="
	>=dev-python/scipy-0.18.1[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.11.3[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-3.1[${PYTHON_USEDEP}]
	"

distutils_enable_tests pytest

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
#	if use examples ; then
#		docinto examples
#		dodoc -r examples/.
#	fi

	distutils-r1_python_install_all
}
