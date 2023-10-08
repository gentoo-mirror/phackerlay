# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Fast and flexible C++ library for working with OpenStreetMap data"
HOMEPAGE="https://github.com/osmcode/libosmium"
SRC_URI="https://github.com/osmcode/libosmium/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

BDEPEND="
	>=dev-libs/boost-1.55
	dev-libs/expat
	sys-libs/zlib
	app-arch/bzip2
	dev-libs/protozero
"

S=${WORKDIR}/lib${P}
