# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11} )
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="trame-router brings Vue Router capabilities into trame widgets and ui"
HOMEPAGE="https://github.com/Kitware/trame-router"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/trame-client[${PYTHON_USEDEP}]
"
