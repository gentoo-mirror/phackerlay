# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_9 python3_10 python3_11 )
DISTUTILS_USE_PEP517=flit

inherit distutils-r1

DESCRIPTION="A bash kernel for Jupyter"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
HOMEPAGE="https://github.com/takluyver/bash_kernel"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""
RDEPEND=">=dev-python/pexpect-4.0"

distutils_enable_tests pytest
