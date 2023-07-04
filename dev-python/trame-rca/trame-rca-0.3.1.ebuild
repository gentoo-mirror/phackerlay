# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11} )
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="Remote Controlled Area widget for trame"
HOMEPAGE="https://github.com/Kitware/trame-rca"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
    dev-python/wslink[${PYTHON_USEDEP}]
    dev-python/trame-client[${PYTHON_USEDEP}]
"

