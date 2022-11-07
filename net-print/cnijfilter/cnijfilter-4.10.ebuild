# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MULTILIB_COMPAT=( abi_x86_{32,64} )

PRINTER_MODEL=( "ix6700" "ix6800" "ip2800" "mx470" "mx530" "ip8700" "e560" "e400" )
PRINTER_ID=( "431" "432" "433" "434" "435" "436" "437" "438" )

inherit ecnij

DESCRIPTION="Canon InkJet Printer Driver for Linux (Pixus/Pixma-Series)"
HOMEPAGE="https://www.canon-europe.com/support/consumer_products/products/printers/inkjet/pixma_ix_series/pixma_ix6840.html?type=drivers&language=en&os=linux%20(64-bit)"
SRC_URI="http://pdisp01.c-wss.com/gdl/WWUFORedirectTarget.do?id=MDEwMDAwNTg1ODAx&cmp=ACB&lang=EN -> ${P}.tar.gz"

RESTRICT="mirror"

PATCHES=(
	"${FILESDIR}"/changes.patch
	"${FILESDIR}"/cups.patch

)


src_install() {
	ecnij_src_install
	for name in pstocanonij cmdtocanonij; do
		dosym ${EPREFIX}/usr/lib64/cups/filter/$name ${EPREFIX}/usr/libexec/cups/filter/$name
	done
}
