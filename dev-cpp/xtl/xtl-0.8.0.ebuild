# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="The x template library "
HOMEPAGE="https://github.com/xtensor-stack/xtl"
SRC_URI="https://github.com/xtensor-stack/xtl/archive/refs/tags/${PV}.tar.gz"
LICENSE="BSD-3"

SLOT="0"
KEYWORDS="amd64"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	cmake_src_configure
}

src_install() {
	cmake_src_install
}

src_test() {
	# override parallel mode only for tests
	local myctestargs=( "-j 1" )
	cmake_src_test
}
