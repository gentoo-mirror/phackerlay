# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=(python2_7)
#checking for uuid_generate in -luuid... yes
#found library uuid
#checking for pthread_create in -lpthread... yes
#found library pthread
#checking for sqlite3_open in -lsqlite3... yes
#found library sqlite3
#checking for SHA1_Init in -lcrypto... yes
#found library crypto
#checking for x86_64-pc-linux-gnu-pkg-config... /usr/bin/x86_64-pc-linux-gnu-pkg-config
#checking pkg-config is at least version 0.9.0... yes
#checking for SSL... yes
#checking for GLIB2... yes
#checking for GOBJECT... yes
#checking for SEARPC... yes
#checking for LIBEVENT... yes
#checking whether /usr/bin/python3.6 version is >= 2.6... yes
#checking for /usr/bin/python3.6 version... 3.6


inherit python-single-r1 vala


#DEPEND=">=sys-devel/automake-1.16.1-r2"

DESCRIPTION="File syncing and sharing software with file encryption and group sharing"
HOMEPAGE="https://github.com/haiwen/seafile-server/ http://www.seafile.com/"
SRC_URI="https://github.com/haiwen/${PN}/archive/v${PV}.tar.gz -> ${PN}.tar.gz"
        #https://github.com/haiwen/seafile-server/archive/v7.1.1-server.tar.gz

#MY_P="${PN}-server"

LICENSE="GPL-2+-with-openssl-exception"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
#REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#RDEPEND="${PYTHON_DEPS}
RDEPEND="net-libs/libsearpc"
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
#	mv ${PN}-${PV}-server ${PN}-${PV}
}

src_prepare() {
	default
	sed -i -e 's/valac /${VALAC} /' lib/Makefile.am || die
#	eautomake
	vala_src_prepare
}


src_configure() {
	./autogen.sh
	default
}

src_install() {
	default
	python_optimize
}
