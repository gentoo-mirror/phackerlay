# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1 udev git-r3
# linux-info - kernel_is

DESCRIPTION="The Coral Gasket Driver allows usage of the Coral EdgeTPU on Linux systems"
HOMEPAGE="https://github.com/google/gasket-driver"
EGIT_REPO_URI="https://github.com/google/gasket-driver.git"
KEYWORDS="~amd64"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

BDEPEND="
	virtual/linux-sources
"

src_prepare() {
	kernel_is ge 6.12.0 && PATCHES+=( "${FILESDIR}"/00-6.12-fix.patch )
	kernel_is ge 6.13.0 && PATCHES+=( "${FILESDIR}"/01-6.13-fix.patch )
	default
}

src_compile() {
	local modargs=( KVERSION="${KV_FULL}" )
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

