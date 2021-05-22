# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Listen to internet radio"
HOMEPAGE="https://gitlab.gnome.org/World/Shortwave"

inherit autotools meson gnome2

SRC_URI="https://gitlab.gnome.org/World/Shortwave/uploads/df12909bb42afbff933e45da0f220eb4/shortwave-1.1.1.tar.xz -> ${P}.tar.xz"
KEYWORDS="~amd64"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	>=dev-db/sqlite-3
	dev-libs/openssl
	>=sys-apps/dbus-1
	>=sys-libs/glibc-2
	>=dev-libs/glib-2
	>=x11-libs/gdk-pixbuf-2
	>=x11-libs/gtk+-3
	>=gui-libs/libhandy-0.0.13
	<gui-libs/libhandy-1
	>=media-libs/gstreamer-1.16
	>=media-plugins/gst-plugins-meta-1.16[mp3,http,aac,opus]
	>=media-libs/gst-plugins-base-1.16
	>=media-libs/gst-plugins-bad-1.16
	>=media-libs/gst-plugins-good-1.16
"
DEPEND="${RDEPEND}"
BDEPEND=""

RESTRICT=network-sandbox

src_unpack() {
    default
	sed -e "s:Audio:Audio;AudioVideo:g" -i ${S}/data/de.haeckerfelix.Shortwave.desktop.in.in
    cd ${WORKDIR}/${P} && eapply ${FILESDIR}/libhandy.patch
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

