# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit webapp

DESCRIPTION="Virtual whiteboard for sketching hand-drawn like diagrams"
HOMEPAGE="https://excalidraw.com/ https://github.com/excalidraw/excalidraw"
SRC_URI="https://github.com/excalidraw/excalidraw/archive/refs/tags/v${PV}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64"
IUSE=""

BDEPEND="
	>=net-libs/nodejs-14
        || ( >=sys-apps/yarn-2.4.2 <sys-apps/yarn-2 )
"
DEPEND="app-admin/webapp-config"

S=${WORKDIR}/${P}

RESTRICT="network-sandbox"
src_prepare() {
	default
	echo 'REACT_APP_WS_SERVER_URL=https://draw.phys-el.ru' > ${S}/.env
	echo '' > ${S}/.env.production

}

src_compile() {
        einfo
	einfo Fetching npm packages with yarn
        einfo
	yarn
	einfo
	einfo Building ${PN}
        einfo
	yarn build app --production=true
}

pkg_setup() {
	webapp_pkg_setup
}

src_install() {
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	doins -r ${S}/build/*

	webapp_src_install
}

#pkg_postinst() {
#	local mydir="${ROOT%/}/${VHOST_ROOT}/${MY_HTDOCSBASE}/${PN}"
#	if [ ! -e $mydir/config.json ]; then
#		einfo Please copy config.sample.json to config.json
#		einfo in $mydir and tune it to your needs
#	fi
#	webapp_pkg_postinst
#}
