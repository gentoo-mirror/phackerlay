# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )

inherit distutils-r1

DESCRIPTION="Simple initrd-aware script to kexec-reboot openrc-running system into grub.cfg first mentioned kernel"
HOMEPAGE="https://gitlab.phys-el.ru/ustinov/kexec-reboot-openrc"
SRC_URI="https://gitlab.phys-el.ru/ustinov/${PN}/-/archive/${PV}/${PN}-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="\
sys-apps/kexec-tools
"

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
