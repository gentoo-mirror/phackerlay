# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8

inherit cmake

DESCRIPTION="Quite Universal Circuit Simulator with ability to use different circuit simulation kernels"
HOMEPAGE="https://ra3xdh.github.io/"
#fn="${PN}-$PV"
SRC_URI="https://github.com/ra3xdh/qucs_s/releases/download/${PV}/${P}.tar.gz"
#S="$WORKDIR/$fn"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-electronics/ngspice
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtsvg:5
	dev-qt/qtscript:5
	dev-qt/qtwidgets:5
	dev-qt/qtprintsupport:5
"
