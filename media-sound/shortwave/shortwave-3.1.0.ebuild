# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools meson gnome2

DESCRIPTION="Listen to internet radio"
HOMEPAGE="https://gitlab.gnome.org/World/Shortwave"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	unset SRC_URI
	KEYWORDS=""
else
	SRC_URI="https://gitlab.gnome.org/World/Shortwave/-/archive/${PV}/${P}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi



LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	>=dev-db/sqlite-3
	>=dev-libs/openssl-1
	>=sys-apps/dbus-1
	>=sys-libs/glibc-2
	>=dev-libs/glib-2
	>=gui-libs/gtk-4
	>=x11-libs/gdk-pixbuf-2
	>=media-libs/gstreamer-1.16
	>=media-plugins/gst-plugins-meta-1.16[mp3,http,aac,opus]
	>=media-libs/gst-plugins-base-1.16
	>=media-libs/gst-plugins-bad-1.16
	>=media-libs/gst-plugins-good-1.16
	>=gui-libs/libadwaita-1.0.0
	>=media-libs/libshumate-1.0.0
"

DEPEND="${RDEPEND}"
BDEPEND=""

RESTRICT=network-sandbox

src_unpack() {
	if [[ ${PV} != *9999* ]]; then
		default
		S=${WORKDIR}/`ls $WORKDIR`
	else
		base_uri="https://gitlab.gnome.org/World/Shortwave.git"
		branch="master"
		git-r3_fetch "${base_uri}/${PN}/core" "refs/heads/${branch}"
		git-r3_checkout "${base_uri}/${PN}/core"
		S="${WORKDIR}/Shortwave"
	fi
}

src_configure() {
	meson_src_configure
}

src_compile() {
	meson_src_compile ${MAKEOPTS}
}

src_install() {
	meson_src_install

	rmdir "${ED}/var/lib" 2>/dev/null
	rmdir "${ED}/var" 2>/dev/null
	rm -fr "${ED}/usr/share/applications/mimeinfo.cache"
}

pkg_preinst() {
	gnome2_pkg_preinst
}
pkg_postinst() {
	gnome2_pkg_postinst
}
pkg_postrm() {
	gnome2_pkg_postrm
}

