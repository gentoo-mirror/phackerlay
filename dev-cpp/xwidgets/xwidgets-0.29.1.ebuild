# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="C++ backend for Jupyter interactive widgets"
HOMEPAGE="https://github.com/jupyter-xeus/xwidgets"
SRC_URI="https://github.com/jupyter-xeus/xwidgets/archive/refs/tags/${PV}.tar.gz"
LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	dev-python/widgetsnbextension
	dev-cpp/xeus-cling
	>=dev-cpp/xproperty-0.11.0
	>=dev-cpp/xeus-3.0.3
	>=dev-cpp/xtl-0.7.0
	<dev-cpp/xtl-0.8.0
"
