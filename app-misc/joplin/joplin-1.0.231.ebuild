# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg

DESCRIPTION="Note taking and to-do application"
HOMEPAGE="https://joplinapp.org/"
SRC_URI="https://github.com/laurent22/joplin/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"

DEPEND="net-libs/nodejs \
	sys-apps/yarn \
"

KEYWORDS="~amd64"

RESTRICT=network-sandbox

src_unpack() {
	default
	mv ${WORKDIR}/* ${WORKDIR}/${P}
}

src_compile() {
	einfo
	einfo 'Note, allowing network access from the sandbox via RESTRICT=network-sandbox'
	einfo
	einfo 'Fetching dependenies via yarn'

	# possibly can hit https://github.com/alfredopalhares/joplin-pkgbuild/issues/25
	export LANG=en_US.utf8

	sed -i '/"husky": ".*"/d' package.json
	yarn install >> yarn.log 2>&1 || die
	einfo "Building ${dir} package via yarn"
	cd ${S}/ElectronClient
	yarn run dist >> ${S}/yarn.log 2>&1 || die
# Cli and Clipper need packaging
#	for dir in ElectronClient CliClient Clipper/popup; do
#		sed -e 's:AppImage:dir:g' -i $dir/package.json
#	done
#	for dir in ElectronClient CliClient Clipper/popup; do
#		einfo "Building ${dir} package via yarn"
#		cd ${S}/${dir}
#		yarn run dist >> ${S}/yarn.log 2>&1 || die
#	done
}

src_install() {
	mkdir -p ${D}/opt/joplin
	cp ${S}/ElectronClient/dist/linux-unpacked/* ${D}/opt/joplin/ -r

#	for dir in ElectronClient CliClient Clipper/popup; do
#		mkdir -p ${D}/opt/joplin/${dir}
#		cp ${S}/${dir}/dist/linux-unpacked/* ${D}/opt/joplin/${dir}/ -r
#	done
	chmod 4755 ${D}/opt/joplin/chrome-sandbox
	dosym /opt/joplin/joplin /usr/bin/joplin

	local size
	for size in 16 24 32 48 72 96 128 256 512; do
		newicon -s ${size} "${S}/Assets/LinuxIcons/${size}x${size}.png" joplin.png
	done
	#newicon -s scalable ${S}/app/images/logo.svg jitsi-meet.svg
	make_desktop_entry "${PN}" Joplin joplin \
		"Office;" \
		"Terminal=false\\nStartupNotify=true\\nStartupWMClass=Joplin"
}

