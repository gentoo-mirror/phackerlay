# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools meson

DESCRIPTION="Shumate is a GTK toolkit providing widgets for embedded maps"
HOMEPAGE="https://gitlab.gnome.org/GNOME/libshumate"

SRC_URI="https://gitlab.gnome.org/GNOME/libshumate/-/archive/1.0.0.alpha.1/libshumate-1.0.0.alpha.1.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="LGPL-2.1"
SLOT="0"

RDEPEND="
	>=dev-libs/glib-2.16
	>=gui-libs/gtk-4
	>=net-libs/libsoup-2.42
	>=dev-db/sqlite-3
	>=x11-libs/cairo-1.4
	>=dev-libs/gobject-introspection-0.6.3
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

