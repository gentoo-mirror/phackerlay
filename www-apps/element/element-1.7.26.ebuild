# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit webapp

DESCRIPTION="Element (formerly known as Vector and Riot) is a Matrix web client built using the Matrix React SDK"
HOMEPAGE="https://element.io"
SRC_URI="https://github.com/vector-im/element-web/releases/download/v${PV}/element-v${PV}.tar.gz"
LICENSE="Apache-2.0"

KEYWORDS="~amd64"

RDEPEND="app-admin/webapp-config"

S=${WORKDIR}/${PN}-v${PV}

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
	if [ ! -e "${MY_HTDOCSDIR}"/config.json ]; then
		elog Please copy config.sample.json to config.json
		elog in ${MY_HTDOCSDIR} and tune it to your needs
	fi
	webapp_pkg_postinst
}
