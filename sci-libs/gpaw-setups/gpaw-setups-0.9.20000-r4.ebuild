# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Setup collection for sci-physics/gpaw"
HOMEPAGE="https://wiki.fysik.dtu.dk/gpaw/setups/setups.html"
SRC_URI="https://wiki.fysik.dtu.dk/gpaw-files/gpaw-setups-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	"

src_compile() {
	gunzip ${S}/*.gz
}

src_install(){
	GPAW_SETUP_PATH=/usr/share/gpaw/setups
	insinto $GPAW_SETUP_PATH
	doins "${S}"/*
	echo "export GPAW_SETUP_PATH=$GPAW_SETUP_PATH" > gpaw-setups.sh
	insinto /etc/bash/bashrc.d
	doins ${S}/gpaw-setups.sh
}

pkg_postinst(){
	einfo
	einfo '	To get $GPAW_SETUP_PATH in already launched shells run'
	einfo '	. /etc/bash/bashrc'
	einfo
}
