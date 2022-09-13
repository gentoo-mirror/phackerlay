# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="The publicly available ELPA library provides highly efficient and highly scalable direct eigensolvers for symmetric matrices"
HOMEPAGE="https://elpa.mpcdf.mpg.de/"

SRC_URI="https://gitlab.mpcdf.mpg.de/elpa/elpa/-/archive/new_release_${PV}/elpa-new_release_${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/elpa-new_release_${PV}"
KEYWORDS="~amd64"

LICENSE="GPL-3"
IUSE="openmp mpi cpu_flags_x86_sse cpu_flags_x86_avx cpu_flags_x86_avx2 cpu_flags_x86_avx512 cpu_flags_x86_sve128 cpu_flags_x86_sve256 cpu_flags_x86_sve512"
SLOT="0"

RDEPEND="
	sys-devel/gcc[fortran]
	app-editors/vim-core
	mpi? ( virtual/mpi[fortran,threads] )
        openmp? ( sys-devel/gcc[openmp] )
	"

CFLAGS="${CFLAGS} -march=native"

src_prepare() {
	default

	${S}/generate_automake_test_programs.py > ${S}/test_programs.am
	eautoreconf --force --install
}


src_configure() {
	econf CPP=g++ --prefix=/usr --libdir=/usr/lib64 \
		$(use_with mpi) \
		$(use_enable openmp) \
		$(use_enable cpu_flags_x86_sse sse) \
		$(use_enable cpu_flags_x86_avx avx) \
		$(use_enable cpu_flags_x86_avx2 avx2) \
		$(use_enable cpu_flags_x86_avx512 avx512) \
		$(use_enable cpu_flags_x86_sve128 sve128) \
		$(use_enable cpu_flags_x86_sve256 sve256) \
		$(use_enable cpu_flags_x86_sve512 sve512) || die
	}

#src_compile() {
#	make ${MAKEOPTS}
#}
