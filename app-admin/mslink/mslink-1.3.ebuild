# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="This application allow you to create Windows Shortcut files (extension .LNK) without needing a Windows OS"
HOMEPAGE="https://www.mamachine.org"
SRC_URI="http://web.archive.org/web/20230313034545/http://www.mamachine.org/mslink/mslink_v${PV}.sh"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S=${WORKDIR}

src_install() {
	mv ${DISTDIR}/mslink_v${PV}.sh ${WORKDIR}/mslink.sh
	dobin mslink.sh
}
