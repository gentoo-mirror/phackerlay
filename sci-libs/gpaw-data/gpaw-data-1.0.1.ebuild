# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1 pypi

DESCRIPTION="Data package for PAW files and other data files for the GPAW DFT code"
# 20250729 gitlab.com project page is private
HOMEPAGE="https://pypi.org/project/gpaw-data"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
