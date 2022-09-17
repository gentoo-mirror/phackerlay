# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Unified Communication X"
HOMEPAGE="https://www.openucx.org"
SRC_URI="https://github.com/openucx/ucx/releases/download/v${PV}/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="+numa +openmp cpu_flags_x86_avx cpu_flags_x86_sse41 cpu_flags_x86_sse42"

RDEPEND="
	sys-libs/binutils-libs:=
	numa? ( sys-process/numactl )
"
DEPEND="${RDEPEND}"

src_configure() {
	BASE_CFLAGS="" \
	econf \
		--disable-compiler-opt \
		--without-go \
		$(use_with cpu_flags_x86_avx avx) \
		$(use_with cpu_flags_x86_sse41 sse41) \
		$(use_with cpu_flags_x86_sse42 sse42) \
		$(use_enable numa) \
		$(use_enable openmp) \
		--without-bfd
}

src_compile() {
	BASE_CFLAGS="" emake
}
