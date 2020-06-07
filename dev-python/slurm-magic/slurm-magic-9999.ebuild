# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1 git-r3

DESCRIPTION="Package implements magic commands for interacting with the SLURM workload manager"
HOMEPAGE="https://github.com/NERSC/slurm-magic"

EGIT_REPO_URI="https://github.com/NERSC/slurm-magic.git"
EGIT_BRANCH="master"
KEYWORDS=""

LICENSE="BSD-2"
SLOT="0"

RESTRICT=network-sandbox

RDEPEND="\
	dev-python/ipython[${PYTHON_USEDEP}]
"

src_unpack() {
        git-r3_fetch
	git-r3_checkout
}

python_compile() {
	distutils-r1_python_compile
}

python_install() {
	distutils-r1_python_install --skip-build
}

python_install_all() {
	distutils-r1_python_install_all
}
