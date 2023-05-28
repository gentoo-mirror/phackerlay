# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11} )
DISTUTILS_USE_PEP517=jupyter

inherit distutils-r1 pypi

DESCRIPTION="A JupyterLab extension to add expression node tokens to jupyterlab-markup"
HOMEPAGE="https://github.com/agoose77/juptyerlab-markup-expr"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

export NPM_CONFIG_LEGACY_PEER_DEPS="true"

RDEPEND="
	>=dev-python/jupyterlab-markup-2.0.0[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

S=${WORKDIR}/jupyterlab_markup_expr-${PV}
