# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1 pypi

DESCRIPTION="Making it easy to write async iterators in Python 3.5"
HOMEPAGE="https://github.com/python-trio/async_generator"

LICENSE="MIT Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

#S=${WORKDIR}/hatch_nodejs_version-${PV}

#distutils_enable_tests pytest
