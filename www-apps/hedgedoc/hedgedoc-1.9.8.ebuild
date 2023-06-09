# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Hedgedoc real-time collaborative markdown editor"
HOMEPAGE="https://hedgedoc.org/"
SRC_URI="https://github.com/hedgedoc/hedgedoc/releases/download/${PV}/hedgedoc-${PV}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

BDEPEND="
	<net-libs/nodejs-20
	>net-libs/nodejs-14
	|| ( <dev-libs/openssl-3 net-libs/nodejs[-system-ssl] )
"

RDEPEND="
	acct-group/hedgedoc
	acct-user/hedgedoc
"

S=${WORKDIR}/${PN}

RESTRICT="network-sandbox"

src_compile() {
	corepack prepare yarn@stable --activate
	einfo
	einfo Fetching npm packages with yarn
	einfo
	yarn install || die
	einfo
	einfo Building hedgedoc
	einfo
	eapply ${FILESDIR}/allow_any_file_upload.patch || die
	yarn run build || die
	einfo
	einfo Removing leftovers
	einfo
	find node_modules -type f \
          \( \
         -iname '*Makefile*' -o \
         -iname '*armv*' -o \
         -iname '*.cache' -o \
         -iname '*Makefile*' -o \
         -iname '*appveyor.yml' -o \
         -iname '*.babelrc' -o \
         -iname '*.bak' -o \
         -iname '*bower.json' -o \
         -iname '*.c' -o \
         -iname '*.cc' -o \
         -iname '*.cpp' -o \
         -iname '*.md' -o \
         -iname '*.markdown' -o \
         -iname '*.rst' -o \
         -iname '*.nycrc' -o \
         -iname '*.npmignore' -o \
         -iname '*.editorconfig' -o \
         -iname '*.el' -o \
         -iname '*.eslintignore' -o \
         -iname '*.eslintrc*' -o \
         -iname '*.fimbullinter.yaml' -o \
         -iname '*.gitattributes' -o \
         -iname '*.gitmodules' -o \
         -iname '*.h' -o \
         -iname '*.html' -o \
         -iname '*.jshintrc' -o \
         -iname '*.jscs.json' -o \
         -iname '*.log' -o \
         -iname '*logo.svg' -o \
         -iname '*.nvmrc' -o \
         -iname '*.o' -o \
         -iname '*package-lock.json' -o \
         -iname '*.travis.yml' -o \
         -iname '*.prettierrc' -o \
         -iname '*.sh' -o \
         -iname '*.tags*' -o \
         -iname '*.Dockerfile*' -o \
         -iname '*.tm_properties' -o \
         -iname '*.wotanrc.yaml' -o \
         -iname '*tsconfig.json' -o \
         -iname '*yarn.lock' \
         \) \
         -delete

	find node_modules -type d \
          \( \
         -iwholename '*.github' -o \
         -iwholename '*.tscache' -o \
         -iwholename '*/man' -o \
         -iwholename '*/test' -o \
         -iwholename '*/scripts' -o \
         -iwholename '*/git-hooks' -o \
         -iwholename '*/linux-arm64' -o \
         -iwholename '*/linux-armvy' -o \
         -iwholename '*/linux-armv7' -o \
         -iwholename '*/win32-ia32' -o \
         -iwholename '*/win32-x64' -o \
         -iwholename '*/darwin-x64' \
         \) \
         -exec rm -rf {} +
	rm public/uploads -rf
}

src_install() {
	insinto "/opt/hedgedoc"
	#insopts -o hedgedoc -g hedgedoc -m 0664
	doins -r app.js package.json bin public lib locales node_modules
	# insopts doesn't affect directories.
	#chown -R hedgedoc:hedgedoc "${ED}/opt/hedgedoc"
	#chmod -R ug=rwX "${ED}/opt/hedgedoc"
	dodir /etc/hedgedoc
	insinto /etc/hedgedoc
	doins config.json.example
	dosym ${EPREFIX}/etc/hedgedoc/config.json ${EPREFIX}/opt/hedgedoc/config.json
	dodir /var/lib/hedgedoc
	dodir /var/lib/hedgedoc
	dodir /var/lib/hedgedoc/public
	keepdir /var/lib/hedgedoc/public/uploads
	chown -R hedgedoc:hedgedoc "${ED}/var/lib/hedgedoc"
	chmod -R ug=rwX "${ED}/var/lib/hedgedoc"
	dosym ${EPREFIX}/var/lib/hedgedoc/public/uploads ${EPREFIX}/opt/hedgedoc/public/uploads

	doinitd ${FILESDIR}/hedgedoc
}

pkg_postinst() {
	elog
	elog Feel free to copy /etc/hedgedoc/config.json.example
	elog over /etc/hedgedoc/config.json and tune it to suite your needs.
	elog Afterwards run
	elog rc-service hedgedoc start
	elog
}
