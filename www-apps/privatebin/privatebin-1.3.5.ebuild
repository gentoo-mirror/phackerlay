# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit webapp

DESCRIPTION="A minimalist, open source online pastebin where the server has zero knowledge of pasted data"
HOMEPAGE="https://privatebin.info/"
SRC_URI="https://github.com/PrivateBin/PrivateBin/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
#SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	>=dev-lang/php-7[fpm,zlib,gd]
"
DEPEND="
	app-admin/webapp-config
"


S=${WORKDIR}/PrivateBin-${PV}

pkg_setup() {
	webapp_pkg_setup
}

src_install() {
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_src_install
}

pkg_postinst() {
	local mydir="${ROOT%/}/${VHOST_ROOT}/${MY_HTDOCSBASE}/${PN}"
	if [ ! -e $mydir/cfg/conf.php ]; then
		einfo Please copy conf.sample.php to conf.php
		einfo in $mydir/cfg and tune it to your needs
	fi
	webapp_pkg_postinst
}
