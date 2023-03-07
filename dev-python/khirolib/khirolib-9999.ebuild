# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9,10,11} )
DISTUTILS_USE_PEP517=setuptools
EGIT_REPO_URI="https://github.com/IgorMIV/khi_robot_py.git"

inherit git-r3 distutils-r1

PROPERTIES="live"

DESCRIPTION="Python library for Kawasaki Robotics"
HOMEPAGE="https://github.com/IgorMIV/khi_robot_py"
KEYWORDS=""
LICENSE="Artistic"
SLOT="0"
IUSE=""
DEPEND=""
