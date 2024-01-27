# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11} )
#DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1 pypi

DESCRIPTION="Making it easy to write async iterators in Python 3.5"
HOMEPAGE="https://github.com/python-trio/async_generator"

LICENSE="MIT Apache2"
SLOT="0"
KEYWORDS="~amd64"

#S=${WORKDIR}/hatch_nodejs_version-${PV}

#distutils_enable_tests pytest
