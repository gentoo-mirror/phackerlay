# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg

DESCRIPTION="A rendition of everyone's favorite 1995 Microsoft operating system for Linux"
HOMEPAGE="https://github.com/grassmunk/Chicago95"
SRC_URI="https://github.com/grassmunk/Chicago95/archive/refs/tags/v${PV}.tar.gz -> Chicago95-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=x11-libs/gtk+-3.22
	>=xfce-base/xfce4-panel-4.12
	>=xfce-base/xfwm4-4.12
	x11-libs/gdk-pixbuf
	xfce-extra/xfce4-panel-profiles
"

S=${WORKDIR}/Chicago95-${PV}

src_install() {
	insinto /usr/share/themes
	doins -r ${S}/Theme/Chicago95
	insinto /usr/share/icons
	doins -r ${S}/Icons/*
	insinto /usr/share/xfce4/helpers
	doins ${S}/Extras/Chicago95_Panel_Preferences.tar.bz2
	elog
	elog	Theme is installed, for information on tuning visit:
	elog	https://github.com/grassmunk/Chicago95/blob/v${PV}/INSTALL.md#enabling-chicago95
	elog	or/and just use supplied helper:
	elog	xfce4-panel-profiles load /usr/share/xfce4/helpers/Chicago95_Panel_Preferences.tar.bz2
	elog	\(note: not all files from original repository are contained in this ebuild,
	elog	please let me know if i should include more\)
	elog
}

pkg_postinst() {
        xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
