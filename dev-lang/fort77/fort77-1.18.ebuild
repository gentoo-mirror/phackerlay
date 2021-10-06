# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Utility is the interface to the FORTRAN compilation system"
HOMEPAGE="https://pubs.opengroup.org/onlinepubs/9699919799/utilities/fort77.html"

inherit autotools

SRC_URI="ftp://ftp.icm.edu.pl/pub/Linux/sunsite/devel/lang/fortran/fort77-${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="public-domain"
SLOT="0"
IUSE="test"

RDEPEND="
	dev-lang/f2c
	dev-lang/perl
	"

PATCHES=(
	"${FILESDIR}"/1_mainmiss.patch
	"${FILESDIR}"/2_m32.patch
)

src_compile () {
	:
}

src_test () {
	make tests
}

src_install () {
	insinto /usr/bin
	dobin fort77
	doman fort77.1
	dosym ${EPREFIX}/usr/bin/fort77 ${EPREFIX}/usr/bin/f77
}
