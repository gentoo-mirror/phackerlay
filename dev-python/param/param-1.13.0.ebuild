# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1
# Pypi sources do not include tests, reported upstream:
# https://github.com/holoviz/param/issues/678

DESCRIPTION="Make Python code clearer and more reliable by declaring Parameters"
HOMEPAGE="https://param.holoviz.org"
SRC_URI="https://github.com/holoviz/param/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
SLOT="0"

distutils_enable_tests pytest
