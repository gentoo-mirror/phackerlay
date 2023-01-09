# Copyright 1998-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="DSO software for Hantek USB digital signal oscilloscopes 6022BE/BL"
HOMEPAGE="https://github.com/OpenHantek/OpenHantek6022"

inherit xdg desktop cmake

SRC_URI="https://github.com/OpenHantek/OpenHantek6022/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	>=dev-qt/qtwidgets-5.4
	>=sci-libs/fftw-3
	>=dev-libs/libusb-1
	dev-qt/qtopengl
	dev-qt/qtprintsupport
	dev-qt/linguist-tools
"

DEPEND="
	${RDEPEND}
	>=dev-util/cmake-3.5
"

BDEPEND=""


src_unpack () {
	default
	mv ${WORKDIR}/* ${WORKDIR}/${P}
}

src_configure () {
	sed -i 's:project(OpenHantek CXX)::g' openhantek/CMakeLists.txt
	cmake_src_configure
}

src_install () {
	cmake_src_install
	mv ${D}/usr/share/doc/openhantek ${D}/usr/share/doc/${P}
	mv ${D}/usr/bin/OpenHantek ${D}/usr/bin/openhantek
}
