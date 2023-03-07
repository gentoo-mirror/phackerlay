# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9,10,11} )
DISTUTILS_USE_PEP517=setuptools
EGIT_REPO_URI="https://github.com/IgorMIV/RoboArt.git"

inherit git-r3 distutils-r1

PROPERTIES="live"

DESCRIPTION="Library for Kawaski Robots painting"
HOMEPAGE="https://github.com/IgorMIV/RoboArt"
KEYWORDS=""
LICENSE="Artistic"
SLOT="0"
IUSE=""
DEPEND=""
