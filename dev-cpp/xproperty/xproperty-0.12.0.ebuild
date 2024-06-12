# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Traitlets-like C++ properties and implementation of the observer pattern"
HOMEPAGE="https://github.com/jupyter-xeus/xproperty"
SRC_URI="https://github.com/jupyter-xeus/xproperty/archive/refs/tags/${PV}.tar.gz"
LICENSE="any.hpp"

SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	=dev-cpp/xtl-0.7*
"
