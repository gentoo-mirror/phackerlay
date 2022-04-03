# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8,9} )

inherit distutils-r1

SRC_URI="https://gitlab.phys-el.ru/ustinov/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="dangerous tool for automatic upgrades*"
HOMEPAGE="https://gitlab.phys-el.ru/gentoo/unattended_emerges"

LICENSE="MIT"
SLOT="0"
# IUSE="+cron-daily cron-weekly news"

RDEPEND="
	sys-apps/portage
"

RESTRICT="test"

S="${WORKDIR}/"
