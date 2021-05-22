# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Listen to internet radio"
HOMEPAGE="https://gitlab.gnome.org/World/Shortwave"

inherit autotools meson gnome2

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.gnome.org/World/Shortwave.git"
	EGIT_BRANCH="master"
	KEYWORDS=""
	SRC_URI=""
else
	SRC_URI="https://gitlab.gnome.org/World/Shortwave/-/archive/${PV}/${P}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

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
	>=media-plugins/gst-plugins-meta-1.16[mp3,http]
	>=media-libs/gst-plugins-base-1.16
	>=media-libs/gst-plugins-bad-1.16
	>=media-libs/gst-plugins-good-1.16
"
DEPEND="${RDEPEND}"
BDEPEND=""

RESTRICT=network-sandbox

src_unpack() {
    if [[ ${PV} == 9999 ]]; then
	git-r3_fetch
        git-r3_checkout
    else
        default
    fi
	mv ${WORKDIR}/*${PV}* ${WORKDIR}/${P}
	${S}=${WORKDIR}/${P}
	sed -e "s:Audio:Audio;AudioVideo:g" -i ${S}/data/de.haeckerfelix.Shortwave.desktop.in.in
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

