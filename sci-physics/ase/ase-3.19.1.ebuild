# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{5,6,7,8} pypy3 )

inherit distutils-r1

DESCRIPTION="A set of tools and Python modules for setting up, manipulating, running, visualizing and analyzing atomistic simulations"
HOMEPAGE="https://wiki.fysik.dtu.dk/ase/ https://pypi.org/project/ase/"
SRC_URI="https://pypi.org/packages/source/a/ase/ase-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+visualize"

RDEPEND="
	>=sci-libs/scipy-0.18.1
	>=dev-python/numpy-1.11.3
	>=dev-python/matplotlib-2
	visualize? ( dev-lang/python[tk] )
	"

#distutils_enable_sphinx docs \
#	dev-python/sphinx-issues \
#	dev-python/pallets-sphinx-themes
#distutils_enable_tests pytest

# XXX: handle Babel better?

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
