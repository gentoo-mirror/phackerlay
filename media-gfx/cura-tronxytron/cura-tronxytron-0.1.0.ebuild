# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

SRC_URI="https://gitlab.phys-el.ru/404/cura-tronxytron/-/archive/v${PV}/unattended_emerges-v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="cura profiles for tronxytron printer"
HOMEPAGE="https://gitlab.phys-el.ru/404/cura-tronxytron"

LICENSE="Artistic"
SLOT="0"

DEPEND="
	media-gfx/cura
"


src_unpack() {
	default
	S="${WORKDIR}/`ls ${WORKDIR}`"
}


src_install() {
	insinto /usr/share/tronxytron
	doins -r resources/*
	into /usr/local
	dobin $FILESDIR/cura
}
