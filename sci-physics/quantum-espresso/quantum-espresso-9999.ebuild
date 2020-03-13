# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
 
EAPI=7
 
DESCRIPTION=" "
HOMEPAGE="https://www.quantum-espresso.org/"

inherit autotools

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/QEF/q-e.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/ganglia/monitor-core/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

S="${WORKDIR}/quantum-espresso-${PV}"
 
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
 
DEPEND="
	virtual/blas
	virtual/lapack
	sci-libs/fftw:3.0
	"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	./configure --prefix ${D}
}

src_compile() {
	make ${MAKEOPTS} all
}
