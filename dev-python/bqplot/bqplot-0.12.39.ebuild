# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

# change for each version bump
FRONTEND_VERSION="0.5.40"

inherit distutils-r1

DESCRIPTION="Plotting library for IPython/Jupyter notebooks"
HOMEPAGE="
	https://github.com/bqplot/bqplot
"
# no js packages
# SRC_URI="mirror://pypi/${PN:0:1}/bqplot/bqplot-${PV}.tar.gz"
SRC_URI="https://github.com/bqplot/bqplot/archive/refs/tags/${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 hppa ~ia64 ~loong ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux"

RESTRICT=network-sandbox

RDEPEND="
	>=dev-python/ipywidgets-8[${PYTHON_USEDEP}]
	<dev-python/ipywidgets-9[${PYTHON_USEDEP}]
	>=dev-python/traitlets-4.3.0[${PYTHON_USEDEP}]
	>=dev-python/traittypes-0.0.6[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.10.4[${PYTHON_USEDEP}]
	<dev-python/numpy-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/pandas-1.0.0[${PYTHON_USEDEP}]
	<dev-python/pandas-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/bqscales-0.3.1[${PYTHON_USEDEP}]
	<dev-python/bqscales-0.4[${PYTHON_USEDEP}]
	net-libs/nodejs[npm]
"

distutils_enable_tests pytest

src_unpack() {
	default
	cd ${S}/js
	npm install --legacy-peer-deps || die
}


src_compile() {
	jupyter labextension build ${S}/js || die
	distutils-r1_src_compile
}


python_install_all() {
        distutils-r1_python_install_all
        mv ${ED}/usr/etc ${ED}/
}

src_install() {
	distutils-r1_src_install
}
