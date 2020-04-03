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
	S="${WORKDIR}/q-e"
else
	SRC_URI="https://elpa.mpcdf.mpg.de/html/Releases/${PV}.pre/elpa-${PV}.pre.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/elpa-${PV}.pre"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="openmp static-libs cpu_flags_x86_avx cpu_flags_x86_avx2"

RDEPEND="
	app-editors/vim-core
	"

src_configure() {
	./configure --prefix=/usr --libdir=/usr/lib64 \
		$(use_enable openmp) \
		$(use_enable static-libs static) \
		$(use_enable cpu_flags_x86_avx avx) \
		$(use_enable cpu_flags_x86_avx2 avx2)
	}

src_compile() {
	make ${MAKEOPTS}
}
