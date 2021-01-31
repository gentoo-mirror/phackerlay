# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

SRC_URI="https://gitlab.phys-el.ru/ustinov/phackerlay/-/blob/master/app-portage/remerge/remerge-0.0.4.ebuild"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Dangerous automatic upgrades script"
HOMEPAGE="https://gitlab.phys-el.ru/ustinov/phackerlay"

LICENSE="Artistic"
SLOT="0"
IUSE="+cron-daily cron-weekly news"

RDEPEND="virtual/mta"

RESTRICT="test"

S="${WORKDIR}/"

pkg_postinst() {
#	newconfd ${FILESDIR}
#	cp "$DISTDIR"/SS SS || die
	elog ""
}

pkg_postrm() {
	ewarn .
}
