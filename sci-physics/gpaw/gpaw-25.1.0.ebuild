# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1

DESCRIPTION="GPAW is a density-functional theory (DFT) Python code based on the projector-augmented wave (PAW) method and the atomic simulation environment (ASE)"
HOMEPAGE="https://wiki.fysik.dtu.dk/gpaw/ https://pypi.org/project/gpaw/"
SRC_URI="https://pypi.org/packages/source/g/gpaw/gpaw-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+setups +fftw +blas_openblas +openmp mpi scalapack vdwxc elpa"

RESTRICT="libvdwxc elpa"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	>=dev-python/scipy-1.6.0[${PYTHON_USEDEP}]
	>=sci-physics/ase-3.22.1[${PYTHON_USEDEP}]
	>=sci-libs/libxc-3
	blas_openblas? ( sci-libs/openblas )
	setups? ( sci-libs/gpaw-setups )
	fftw? ( sci-libs/fftw )
        mpi? ( virtual/mpi sci-libs/fftw[mpi] )
        scalapack? ( sci-libs/scalapack )
        elpa? ( =sci-libs/elpa-2024.05.001 )
	"
	# mind elpa version below

REQUIRED_USE="
	^^ ( blas_openblas )
"

distutils_enable_tests pytest

pkg_pretend() {
	use openmp && ( tc-check-openmp || die )
}

src_configure() {
	GPAW_CONFIG=${S}/siteconfig.py
	touch ${GPAW_CONFIG}
	echo "libraries = ['xc']" >> ${GPAW_CONFIG}
	echo "extra_compile_args = []" >> ${GPAW_CONFIG}
	echo "extra_link_args = []" >> ${GPAW_CONFIG}
	echo "include_dirs = []" >> ${GPAW_CONFIG}

	if use scalapack; then
		echo "scalapack = True" >> ${GPAW_CONFIG}
		echo "libraries += ['scalapack']" >> ${GPAW_CONFIG}
	fi
	if use mpi; then
		echo "mpi = True" >> ${GPAW_CONFIG}
		echo "libraries += ['mpi']" >> ${GPAW_CONFIG}
		echo "compiler = 'mpicc'" >> ${GPAW_CONFIG}
		if use fftw; then
			echo "libraries += ['fftw3_mpi']" >> ${GPAW_CONFIG}
		fi
	fi
	if use openmp; then
		echo "extra_compile_args += ['-fopenmp']" >> ${GPAW_CONFIG}
		echo "extra_link_args += ['-fopenmp']" >> ${GPAW_CONFIG}
	fi
	if use elpa; then
		echo "elpa = True" >> ${GPAW_CONFIG}
		if has_version sci-libs/elpa[openmp]; then
			echo "libraries += ['elpa_openmp']" >> ${GPAW_CONFIG}
			echo "include_dirs += ['${EPREFIX}/usr/include/elpa_openmp-2024.05.001']" >> ${GPAW_CONFIG}
		else

			echo "libraries += ['elpa']" >> ${GPAW_CONFIG}
			echo "include_dirs += ['${EPREFIX}/usr/include/elpa-2024.05.001']" >> ${GPAW_CONFIG}
		fi
	fi
	if use fftw; then
		if has_version sci-libs/fftw[openmp]; then
			echo "libraries += ['fftw3_omp']" >> ${GPAW_CONFIG}
		fi
		echo "libraries += ['fftw3', 'openblas']" >> ${GPAW_CONFIG}
		echo "fftw = True" >> ${GPAW_CONFIG}
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
