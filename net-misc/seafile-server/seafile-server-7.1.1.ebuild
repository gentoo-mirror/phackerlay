# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=(python2_7)

inherit autotools python-single-r1 vala

DESCRIPTION="File syncing and sharing software with file encryption and group sharing"
HOMEPAGE="https://github.com/haiwen/seafile-server/ http://www.seafile.com/"
SRC_URI="https://github.com/haiwen/${PN}/archive/v${PV}-server.tar.gz -> ${PN}.tar.gz"
        #https://github.com/haiwen/seafile-server/archive/v7.1.1-server.tar.gz

MY_P="${PN}-server"

LICENSE="GPL-2+-with-openssl-exception"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
#REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	net-libs/libsearpc
	net-libs/ccnet-server
	net-libs/libevhtp
	>=app-arch/libarchive-2.8.5
	>=sys-fs/fuse-2.7.3
	dev-python/django"
#	dev-libs/glib:2
#	dev-libs/libevent:0
#	dev-libs/jansson
#	sys-libs/zlib:0
#	net-misc/curl
#	dev-libs/openssl:0
#	dev-db/sqlite:3
#	>=sys-devel/automake-1.16.1-r2:1.16"
DEPEND="${RDEPEND}
	$(vala_depend)"

src_unpack() {
	default
	mv ${PN}-${PV}-server ${PN}-${PV}
}

src_prepare() {
	default
	sed -i -e 's/valac /${VALAC} /' lib/Makefile.am || die
#	eautoreconf
	vala_src_prepare
}

src_configure() {
	./autogen.sh
	default
}

src_install() {
	default
	# Remove unnecessary .la files, as recommended by ltprune.eclass
	find "${ED}" -name '*.la' -delete || die
	python_optimize
	python_fix_shebang "${ED}"/usr/bin
}
