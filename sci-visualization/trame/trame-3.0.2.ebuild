# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11} )

inherit distutils-r1 pypi

DESCRIPTION="Trame lets you weave various components and technologies into a Web Application solely written in Python"
HOMEPAGE="https://github.com/Kitware/trame"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
    >=dev-python/trame-server-2.11.7[${PYTHON_USEDEP}]
    >=dev-python/trame-client-2.10.0[${PYTHON_USEDEP}]
"

