# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1 pypi

DESCRIPTION="Custom Spawner for Jupyterhub to start servers in batch scheduled systems "
HOMEPAGE="https://github.com/jupyterhub/batchspawner"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/async_generator-1.8[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]
	>=dev-python/jupyterhub-1.5.1[${PYTHON_USEDEP}]
"
