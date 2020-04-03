# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="The publicly available ELPA library provides highly efficient and highly scalable direct eigensolvers for symmetric matrices"
HOMEPAGE="https://elpa.mpcdf.mpg.de/"

inherit autotools

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://gitlab.mpcdf.mpg.de/elpa/elpa.git"
	EGIT_CHECKOUT="ELPA-${PV}"
	KEYWORDS=""
	S="${WORKDIR}/elpa"
else
	SRC_URI="https://elpa.mpcdf.mpg.de/html/Releases/${PV}/elpa-${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/elpa-${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="openmp cpu_flags_x86_sse cpu_flags_x86_avx cpu_flags_x86_avx2 cpu_flags_x86_avx512"

RDEPEND="
	app-editors/vim-core
	"

src_configure() {
	./configure --prefix=/usr --libdir=/usr/lib64 \
		$(use_enable openmp) \
		$(use_enable cpu_flags_x86_sse sse) \
		$(use_enable cpu_flags_x86_avx avx) \
		$(use_enable cpu_flags_x86_avx2 avx2) \
		$(use_enable cpu_flags_x86_avx512 avx512) 
	}

src_compile() {
	make ${MAKEOPTS} all
}
