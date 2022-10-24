# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools meson

DESCRIPTION="Shumate is a GTK toolkit providing widgets for embedded maps"
HOMEPAGE="https://gitlab.gnome.org/GNOME/libshumate"

SRC_URI="https://gitlab.gnome.org/GNOME/libshumate/-/archive/${PV}/libshumate-${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS=""

LICENSE="LGPL-2.1"
SLOT="0"

RDEPEND="
	>=dev-libs/glib-2.16
	>=gui-libs/gtk-4
	>=net-libs/libsoup-2.42
	>=dev-db/sqlite-3
	>=x11-libs/cairo-1.4
	>=dev-libs/gobject-introspection-0.6.3
	net-libs/libsoup:3.0
	!gui-libs/libshumate
"

DEPEND="${RDEPEND}"
BDEPEND=""

#RESTRICT=network-sandbox

src_unpack() {
		default
		S=${WORKDIR}/`ls $WORKDIR`
}

src_configure() {
	meson_src_configure -Dgtk_doc=false
}

src_compile() {
	meson_src_compile ${MAKEOPTS}
}

src_install() {
	meson_src_install
}

