# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=scikit-build-core
PYTHON_COMPAT=( python3_{12,13} )
#DISTUTILS_EXT=1

inherit distutils-r1

DESCRIPTION="A grounder and solver for logic programs"
HOMEPAGE="
	https://github.com/potassco/clingo
"
SRC_URI="https://github.com/potassco/clingo/archive/refs/tags/v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests pytest

BDEPEND="
	dev-python/scikit-build[${PYTHON_USEDEP}]
"

RDEPEND="
	dev-python/cffi[${PYTHON_USEDEP}]
"


