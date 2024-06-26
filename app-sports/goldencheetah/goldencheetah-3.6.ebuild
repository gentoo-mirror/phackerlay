# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils

DESCRIPTION="Performance Software for Cyclists, Runners, Triathletes and Coaches"
HOMEPAGE="https://github.com/GoldenCheetah/GoldenCheetah"
SRC_URI="https://github.com/GoldenCheetah/GoldenCheetah/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-qt/qtwebengine:5[widgets]
	dev-qt/qtcharts:5
	dev-qt/qtxml:5
	dev-qt/qtsql:5
	dev-qt/qtnetwork:5
	dev-qt/qtsvg:5
	dev-qt/qtwebchannel:5
	dev-qt/qtpositioning:5
	dev-qt/qtmultimedia:5
	dev-qt/qtserialport:5
	dev-qt/qtconcurrent:5
	x11-libs/qwt:6[qt5]
	sci-libs/gsl
"

DEPEND="${RDEPEND}"
BDEPEND="
	>=sys-devel/bison-3.7
	sys-devel/flex
"

S="${WORKDIR}"/GoldenCheetah-${PV}

export INSTALL_ROOT=${D}

src_prepare() {
	default
	cp ${S}/qwt/qwtconfig.pri.in ${S}/qwt/qwtconfig.pri
	cp ${S}/src/gcconfig.pri.in ${S}/src/gcconfig.pri
	echo 'GSL_INCLUDES = /usr/include' >> ${S}/src/gcconfig.pri
	echo 'GSL_LIBS = -lgsl -lgslcblas -lm' >> ${S}/src/gcconfig.pri
	echo 'CONFIG += release'  >> ${S}/src/gcconfig.pri
	echo 'DEFINES += NOWEBKIT'  >> ${S}/src/gcconfig.pri
	echo 'QMAKE_MOVE = cp' >> ${S}/src/gcconfig.pri
	echo 'LIBZ_LIBS    = -lz' >> ${S}/src/gcconfig.pri

	eqmake5 build.pro || die
}

src_install() {
	default
	dobin ${S}/src/GoldenCheetah
}
