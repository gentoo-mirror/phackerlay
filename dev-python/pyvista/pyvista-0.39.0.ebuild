# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_SINGLE_IMPL=1  # because "sci-libs/vtk" inherits "python-single-r1"
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Easier Pythonic interface to VTK"
HOMEPAGE="https://docs.pyvista.org"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"

RDEPEND="
	sci-libs/vtk[python,imaging,rendering,views,${PYTHON_SINGLE_USEDEP}]
	$(python_gen_cond_dep '
		<dev-python/numpy-1.25.0[${PYTHON_USEDEP}]
		<dev-python/matplotlib-3.7.2[${PYTHON_USEDEP}]
		<dev-python/pillow-9.6.0[${PYTHON_USEDEP}]
		>=dev-python/scooby-0.5.1[${PYTHON_USEDEP}]
		<dev-python/scooby-0.8.0[${PYTHON_USEDEP}]
	')
"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest
