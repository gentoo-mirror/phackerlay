# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="C++ backend for the bqplot 2-D plotting library"
HOMEPAGE="https://github.com/QuantStack/xplot"
# SRC_URI="https://github.com/QuantStack/xplot/archive/refs/tags/${PV}.tar.gz"
EGIT_REPO_URI="https://github.com/QuantStack/xplot.git"
LICENSE="BSD"

SLOT="0"
KEYWORDS=""

PATCHES=(
	"${FILESDIR}/xproperty.patch"
	"${FILESDIR}/xwidget-api.patch"
)



BDEPEND="
	<dev-python/bgplot-1.12.0
	=dev-cpp/xwidgets-0.20.0
	=dev-cpp/xeus-0.23.3
	=dev-cpp/xproperty-0.10.1
	=dev-cpp/xtl-0.6.5
	=dev-cpp/cppzmq-4.3.0
"
