# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8

inherit cmake xdg

DESCRIPTION="Quite Universal Circuit Simulator with ability to use different circuit simulation kernels"
HOMEPAGE="https://ra3xdh.github.io/"
#fn="${PN}-$PV"
SRC_URI="https://github.com/ra3xdh/qucs_s/releases/download/${PV}/${P}.tar.gz"
#S="$WORKDIR/$fn"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	sci-electronics/ngspice
	dev-qt/qtbase:6[gui,widgets]
	dev-qt/qtsvg:6
	dev-qt/qtcharts:6
"
src_configure() {
        local mycmakeargs=(
                -DWITH_QT6=ON
        )
	cmake_src_configure
}


src_install() {
	cmake_src_install
	cd ${D}/usr/share/qucs-s/library
	mv BJT_Extended.lib BJT_Extended_.lib
	mv DiodesSchottky.lib DiodesSchottky_.lib
	mv Tubes.lib Tubes_.lib
	mv BF998.lib BF998_.lib
	mv PhotovoltaicRelay.lib PhotovoltaicRelay_.lib
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
