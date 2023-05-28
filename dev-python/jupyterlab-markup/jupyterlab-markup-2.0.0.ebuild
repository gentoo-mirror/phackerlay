# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11} )
DISTUTILS_USE_PEP517=jupyter

inherit distutils-r1 pypi

DESCRIPTION="JupyterLab extension to enable markdown-it rendering, with support for markdown-it plugins"
HOMEPAGE="https://github.com/agoose77/jupyterlab-markup"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="network-sandbox"

export NPM_CONFIG_LEGACY_PEER_DEPS="true"

RDEPEND="
	<dev-python/jupyterlab-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/jupyterlab-3.0.0[${PYTHON_USEDEP}]
"
BDEPEND="
	net-libs/nodejs[npm]
"

PATCHES=(
	"${FILESDIR}/tsconfig.patch"
)

S=${WORKDIR}/jupyterlab_markup-${PV}

distutils_enable_tests pytest
