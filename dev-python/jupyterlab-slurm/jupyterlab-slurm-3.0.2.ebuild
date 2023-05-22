# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9,10,11} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="A Jupyter Notebook server extension that implements common Slurm commands"
HOMEPAGE="https://github.com/NERSC/jupyterlab-slurm"
SRC_URI="https://github.com/NERSC/jupyterlab-slurm/archive/refs/tags/v${PV}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="network-sandbox"

RDEPEND="\
	>=dev-python/jupyter-packaging-0.10.0[${PYTHON_USEDEP}]
	>=dev-python/jupyterlab-3.0.0[${PYTHON_USEDEP}]
	sys-cluster/slurm
"

distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all
	mv "${ED}/usr/etc" "${ED}/etc" || die
}
