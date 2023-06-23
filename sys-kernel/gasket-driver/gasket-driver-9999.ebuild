# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1 toolchain-funcs udev

DESCRIPTION="The Coral Gasket Driver allows usage of the Coral EdgeTPU on Linux systems"
HOMEPAGE="https://github.com/google/gasket-driver"

inherit git-r3
EGIT_REPO_URI="https://github.com/google/gasket-driver.git"
KEYWORDS="~amd64"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

BDEPEND="
	virtual/linux-sources
"

MODULES_KERNEL_MAX=6.0.0

src_compile() {
	local modargs=( KSRC=${KERNEL_DIR} )
	local modlist=( gasket=drivers/pci/pcie:${S}/src apex=drivers/pci/pcie:${S}/src )

	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install
	insinto /lib/udev/rules.d
	newins ${S}/debian/gasket-dkms.udev 60-gasket.rules
}

pkg_postinst() {
	linux-mod-r1_pkg_postinst
	udev_reload
}

