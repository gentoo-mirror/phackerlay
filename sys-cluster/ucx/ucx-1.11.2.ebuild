# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

MY_PV=${PV/_/-}
DESCRIPTION="Unified Communication X"
HOMEPAGE="https://www.openucx.org"
SRC_URI="https://github.com/openucx/ucx/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 -riscv ~x86 ~amd64-linux ~x86-linux"
IUSE="+numa +openmp"

RDEPEND="
	sys-libs/binutils-libs:=
	numa? ( sys-process/numactl )
"
DEPEND="${RDEPEND}"

PATCHES=(
	${FILESDIR}/01-binutils-2.39-compat.patch
	${FILESDIR}/02-drop-development-flags.patch
	${FILESDIR}/03-cstdint.patch
)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	BASE_CFLAGS="" \
	econf \
		--disable-compiler-opt \
		$(use_enable numa) \
		$(use_enable openmp)
}

src_compile() {
	BASE_CFLAGS="" emake
}
