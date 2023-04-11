# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Jupyterhub MOdular Slurm Spawner"
HOMEPAGE="https://github.com/silx-kit/jupyterhub_moss"
SRC_URI="https://github.com/silx-kit/jupyterhub_moss/archive/refs/tags/v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/batchspawner-1.0[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/jupyterhub[${PYTHON_USEDEP}]
	dev-python/pydantic[${PYTHON_USEDEP}]
	dev-python/traitlets[${PYTHON_USEDEP}]
"

src_unpack() {
	default
	rm -rf ${S}/test || die
}
