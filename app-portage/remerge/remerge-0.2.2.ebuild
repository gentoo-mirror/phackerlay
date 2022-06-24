# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8,9,10,11} )

inherit distutils-r1

DESCRIPTION="Continue unsuccessfull merge of last ebuild from /var/log/emerge.log"
HOMEPAGE="https://gitlab.phys-el.ru/ustinov/remerge"
SRC_URI="https://gitlab.phys-el.ru/ustinov/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"


RDEPEND="
	sys-apps/portage[${PYTHON_USEDEP}]
"

src_unpack () {
	default
	S=${WORKDIR}/${PN}-v${PV}
}

src_prepare() {
	distutils-r1_src_prepare
}

python_compile() {
	distutils-r1_python_compile
}

python_install() {
	distutils-r1_python_install --skip-build
}

python_install_all() {
	distutils-r1_python_install_all
}
