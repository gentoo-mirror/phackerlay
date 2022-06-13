# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit webapp

DESCRIPTION="Web-based self-hosted groceries & household management solution for your home"
HOMEPAGE="https://grocy.info/"
SRC_URI="https://github.com/grocy/grocy/releases/download/v${PV}/grocy_${PV}.zip -> ${P}.zip"


LICENSE="MIT"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	>=dev-lang/php-7[ctype,curl,fpm,exif,fileinfo,gd,iconv,phar,ldap,simplexml,sqlite,tokenizer,zip,intl]
"
DEPEND="
	app-admin/webapp-config
"

S=${WORKDIR}

pkg_setup() {
	webapp_pkg_setup
}

src_install() {
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	dodir "${MY_HTDOCSDIR}"/data
	webapp_serverowned -R "${MY_HTDOCSDIR}"/data

	webapp_src_install
}

pkg_postinst() {
	webapp_pkg_postinst
	local mydir="${VHOST_ROOT}/${MY_HTDOCSBASE}/${PN}"
	echo data/config.php
	if [ ! -e $mydir/data/config.php ]; then
		elog
		elog Please copy config-dist.php to data/config.php
		elog in $mydir and tune it to your needs
		elog
	else
		elog
		elog See release notes at
		elog https://github.com/grocy/releases/tag/v${PV}
		elog https://github.com/grocy/grocy#how-to-update
		elog
		elog And maybe look at diff config-dist.php data/config.php at
		elog $mydir
		elog

	fi
}
