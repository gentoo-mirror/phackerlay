# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{9,10,11} )

inherit distutils-r1

DESCRIPTION="GPAW is a density-functional theory (DFT) Python code based on the projector-augmented wave (PAW) method and the atomic simulation environment (ASE)"
HOMEPAGE="https://wiki.fysik.dtu.dk/gpaw/ https://pypi.org/project/gpaw/"
SRC_URI="https://pypi.org/packages/source/g/gpaw/gpaw-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+setups +fftw +openmp mpi scalapack vdwxc elpa"

RESTRICT="libvdwxc elpa"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	>=dev-python/scipy-1.6.0[${PYTHON_USEDEP}]
	>=sci-physics/ase-3.22.1[${PYTHON_USEDEP}]
	>=sci-libs/libxc-3
	virtual/blas
	setups? ( sci-libs/gpaw-setups )
	fftw? ( sci-libs/fftw )
        mpi? ( virtual/mpi )
        scalapack? ( sci-libs/scalapack )
        elpa? ( sci-libs/scalapack =sci-libs/elpa-2021.11.001 )
	"
	# mind elpa version below

distutils_enable_tests pytest

pkg_pretend() {
	use openmp && tc-check-openmp || die
}

src_configure() {
	cp ${S}/siteconfig_example.py ${S}/siteconfig.py
	GPAW_CONFIG=${S}/siteconfig.py
	if use fftw; then
		sed -e "s:fftw = False:fftw = True:g" -i ${S}/siteconfig.py || die
		sed -e "s:'fftw3':'fftw3','blas':g" -i ${S}/siteconfig.py || die
	else
		sed -e "s:fftw = True:fftw = False:g" -i ${S}/siteconfig.py || die
	fi
	if use scalapack; then
		sed -e "s:scalapack = False:scalapack = True:g" -i ${S}/siteconfig.py || die
		sed -e "s:'scalapack-openmpi':'scalapack':g" -i ${S}/siteconfig.py || die
	else
		sed -e "s:scalapack = True:scalapack = False:g" -i ${S}/siteconfig.py || die
	fi
	if use mpi; then
		echo "libraries += ['mpi']" >> ${S}/siteconfig.py || die
	else
		sed -e "s:os.name != 'nt':False:g" -i ${S}/setup.py || die
	fi
	if use openmp; then
		echo "extra_compile_args += ['-fopenmp']" >> ${S}/siteconfig.py
		echo "extra_link_args += ['-fopenmp']" >> ${S}/siteconfig.py
	fi
	if use elpa; then
		echo "elpa = True" >> ${S}/siteconfig.py
		if use openmp; then
			echo "libraries += ['elpa_openmp']" >> ${S}/siteconfig.py
			echo "include_dirs += ['/usr/include/elpa_openmp-2021.11.001']" >> ${S}/siteconfig.py
		else
			echo "libraries += ['elpa']" >> ${S}/siteconfig.py
			echo "include_dirs += ['/usr/include/elpa-2021.11.001']" >> ${S}/siteconfig.py
	fi
	fi
}


src_prepare() {
	distutils-r1_src_prepare
}

python_compile() {
        unset CC
	distutils-r1_python_compile
}

python_install() {
        unset CC
	distutils-r1_python_install --skip-build
}

python_install_all() {
        unset CC
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
