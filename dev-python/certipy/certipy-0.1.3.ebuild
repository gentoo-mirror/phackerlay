# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1 pypi

DESCRIPTION="A simple python tool for creating certificate authorities and certificates on the fly."
HOMEPAGE="https://github.com/LLNL/certipy"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="\
	dev-python/jupyterhub[${PYTHON_USEDEP}] \
"

distutils_enable_tests pytest
