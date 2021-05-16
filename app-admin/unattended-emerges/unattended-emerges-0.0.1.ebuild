# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

SRC_URI="https://gitlab.phys-el.ru/ustinov/phackerlay/-/raw/master/app-admin/unattended-upgrades/files/unattended-upgrades"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Dangerous automatic upgrades script"
HOMEPAGE="https://gitlab.phys-el.ru/ustinov/phackerlay"

LICENSE="Artistic"
SLOT="0"
IUSE="+cron-daily cron-weekly news"

RDEPEND="
	virtual/mta
	virtual/cron
	app-admin/restart-services
"

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
