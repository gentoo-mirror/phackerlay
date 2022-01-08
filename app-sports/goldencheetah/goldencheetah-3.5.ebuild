# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg qmake-utils

DESCRIPTION="(sorry, broken ATM, as needs patching to build on gcc10, will wait for upstream) Performance Software for Cyclists, Runners, Triathletes and Coaches"
HOMEPAGE="https://github.com/GoldenCheetah/GoldenCheetah"
SRC_URI="https://github.com/GoldenCheetah/GoldenCheetah/archive/refs/tags/V${PV}.tar.gz -> ${P}.tar.gz"

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
	sci-lib/gsl
"

DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/bison
	sys-devel/flex
"

S="${WORKDIR}"/GoldenCheetah-${PV}

src_prepare() {
	default
	cp ${S}/qwt/qwtconfig.pri.in ${S}/qwt/qwtconfig.pri
	cp ${S}/src/gcconfig.pri.in ${S}/src/gcconfig.pri
	echo 'GSL_INCLUDES = /usr/include' >> ${S}/src/gcconfig.pri
	echo 'GSL_LIBS = -lgsl -lgslcblas -lm' >> ${S}/src/gcconfig.pri
	echo 'CONFIG += release'  >> ${S}/src/gcconfig.pri
	echo 'DEFINES += NOWEBKIT'  >> ${S}/src/gcconfig.pri
	#cmake_src_prepare
	xdg_src_prepare
}

src_compile() {
	cd ${S}
	qmake -recursive
	default
}

src_install() {
#	docompress -x /usr/share/doc/${PF}/html
	default
	cmake_src_install
#	mv "${D}"/usr/share/doc/HTML "${D}"/usr/share/doc/${PF}/html || die "mv Qt help failed"
}
