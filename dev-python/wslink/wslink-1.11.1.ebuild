# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11} )
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="Python/JavaScript library for communicating over WebSocket"
HOMEPAGE="https://github.com/Kitware/wslink"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"


