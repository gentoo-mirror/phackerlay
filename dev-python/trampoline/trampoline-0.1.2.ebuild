# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1

DESCRIPTION="Simple and tiny yield-based trampoline implementation for python"
HOMEPAGE="https://gitlab.com/ferreum/trampoline"
# pypi has no tar.gz for 0.1.2
SRC_URI="https://gitlab.com/ferreum/trampoline/-/archive/1d98f39c3015594e2ac8ed48dccc2f393b4dd82b/trampoline-1d98f39c3015594e2ac8ed48dccc2f393b4dd82b.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

