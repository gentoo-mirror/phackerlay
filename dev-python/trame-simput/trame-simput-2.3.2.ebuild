# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=true
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11} )

inherit distutils-r1 pypi

DESCRIPTION="Simput implementation for trame "
HOMEPAGE="https://github.com/Kitware/trame-simput"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
    dev-python/pyyaml[${PYTHON_USEDEP}]
    dev-python/trame-client[${PYTHON_USEDEP}]
"

