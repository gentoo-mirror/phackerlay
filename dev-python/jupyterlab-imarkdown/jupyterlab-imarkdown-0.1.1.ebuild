# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11} )
DISTUTILS_USE_PEP517=jupyter

inherit distutils-r1 pypi

DESCRIPTION="Embed rich output in Markdown cells"
HOMEPAGE="https://github.com/agoose77/jupyterlab-imarkdown"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	<dev-python/jupyterlab-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/jupyterlab-3.0.0[${PYTHON_USEDEP}]
	dev-python/jupyterlab-markup-expr[${PYTHON_USEDEP}]
"
BDEPEND="
	net-libs/nodejs[npm]
"

S=${WORKDIR}/jupyterlab_imarkdown-${PV}

distutils_enable_tests pytest
