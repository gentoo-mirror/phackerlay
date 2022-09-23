# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry

PYTHON_COMPAT=( python3_{8,9,10,11} )
inherit distutils-r1

DESCRIPTION="Canonical JSON"
HOMEPAGE="https://github.com/matrix-org/python-canonicaljson https://pypi.python.org/pypi/canonicaljson"
SRC_URI="https://github.com/matrix-org/python-canonicaljson/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/python-${P}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-python/simplejson-3.14.0"
RDEPEND="${DEPEND}"

distutils_enable_tests pytest
