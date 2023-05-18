# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod toolchain-funcs udev

DESCRIPTION="The Coral Gasket Driver allows usage of the Coral EdgeTPU on Linux systems"
HOMEPAGE="https://github.com/google/gasket-driver"

inherit git-r3
EGIT_REPO_URI="https://github.com/google/gasket-driver.git"
KEYWORDS="~amd64"

LICENSE="GPL-2.0"
SLOT="0"
IUSE="dist-kernel"

BDEPEND="
	virtual/linux-sources
"

BUILD_PARAMS="CC=$(tc-getCC) V=1 KSRC=${KERNEL_DIR}"
MODULE_NAMES="gasket(drivers/pci/pcie:${S}/src) apex(drivers/pci/pcie:${S}/src)"
BUILD_TARGETS="all"

src_install() {
	linux-mod_src_install
	insinto /lib/udev/rules.d
	newins ${S}/debian/gasket-dkms.udev 60-gasket.rules
}

pkg_postinst() {
	linux-mod_pkg_postinst
	udev_reload
}

pkg_postrm() {
	linux-mod_pkg_postrm
	udev_reload
}
