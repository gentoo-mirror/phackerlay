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
	!!>=virtual/dist-kernel-6
	!!>=sys-kernel/gentoo-sources-6
	!!>=sys-kernel/vanilla-sources-6
	!!>=sys-kernel/git-sources-6
	!!>=sys-kernel/mips-sources-6
	!!>=sys-kernel/pf-sources-6
	!!>=sys-kernel/rt-sources-6
	!!>=sys-kernel/zen-sources-6
	!!>=sys-kernel/raspberrypi-sources-6
	!!>=sys-kernel/gentoo-kernel-6
	!!>=sys-kernel/gentoo-kernel-bin-6
	!!>=sys-kernel/vanilla-kernel-6
"
RDEPEND="
	dist-kernel? ( || ( <virtual/dist-kernel-6 <sys-kernel/vanilla-kernel-6 ) )
"


# kernel list may be dropped after 6 branch support

#BUILD_PARAMS="CC=$(tc-getCC) V=1 KSRC=${KERNEL_DIR}"
#MODULE_NAMES="gasket(drivers/pci/pcie:${S}/src) apex(drivers/pci/pcie:${S}/src)"
#BUILD_TARGETS="all"


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

