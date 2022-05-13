# Copyright 1999-2022 Gentoo Foundation
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


#RESTRICT="test"



src_unpack() {
	default
#	S=${WORKDIR}
S="${WORKDIR}/`ls ${WORKDIR}`"
}


src_install() {
	insinto /usr/share/cura
	doins -r resources
}
