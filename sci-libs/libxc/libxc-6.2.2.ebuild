# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A library of exchange-correlation functionals for use in DFT"
HOMEPAGE="https://octopus-code.org/wiki/Libxc"
SRC_URI="https://gitlab.com/libxc/libxc/-/archive/${PV}/${P}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux"
IUSE="fortran test"
RESTRICT="!test? ( test )"

src_configure() {
        local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DENABLE_FORTRAN="$(usex fortran ON OFF)"
        )
        cmake_src_configure
}
