# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{5,6,7,8} )

inherit distutils-r1

DESCRIPTION="GPAW is a density-functional theory (DFT) Python code based on the projector-augmented wave (PAW) method and the atomic simulation environment (ASE)"
HOMEPAGE="https://wiki.fysik.dtu.dk/gpaw/ https://pypi.org/project/gpaw/"
SRC_URI="https://pypi.org/packages/source/g/gpaw/gpaw-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+setups +fftw mpi scalapack vdwxc elpa"

RESTRICT="libvdwxc elpa"

RDEPEND="
	>=sci-libs/scipy-0.14
	>=dev-python/numpy-1.9
	>=sci-physics/ase-3.18
	>=sci-libs/libxc-3
	virtual/blas
	setups? ( sci-libs/gpaw-setups )
	fftw? ( sci-libs/fftw )
        mpi? ( virtual/mpi )
        scalapack? ( sci-libs/scalapack )
        elpa? ( sci-libs/scalapack =sci-libs/elpa-20171201 )
	"

#distutils_enable_sphinx docs \
#	dev-python/sphinx-issues \
#	dev-python/pallets-sphinx-themes
#distutils_enable_tests pytest

# XXX: handle Babel better?

src_configure() {
	cp ${S}/siteconfig_example.py ${S}/siteconfig.py
	GPAW_CONFIG=${S}/siteconfig.py
	if use fftw; then
		sed -e "s:fftw = False:fftw = True:g" -i ${S}/siteconfig.py || die
		sed -e "s:'fftw3':'fftw3','blas':g" -i ${S}/siteconfig.py || die
	fi
	if use scalapack; then
		sed -e "s:scalapack = False:scalapack = True:g" -i ${S}/siteconfig.py || die
		sed -e "s:'scalapack-openmpi':'scalapack':g" -i ${S}/siteconfig.py || die
	fi
	if use mpi; then
		echo "libraries += ['mpi']" >> ${S}/siteconfig.py || die
	fi
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
#	if use examples ; then
#		docinto examples
#		dodoc -r examples/.
#	fi

	distutils-r1_python_install_all
}

pkg_postinst() {
	if ! use setups; then
		einfo
		einfo '	You have not selected "setups" flag, see'
		einfo '	https://wiki.fysik.dtu.dk/gpaw/install.html#install-paw-datasets'
		einfo '	for info on installing PAW datasets'
		einfo
	fi
}
