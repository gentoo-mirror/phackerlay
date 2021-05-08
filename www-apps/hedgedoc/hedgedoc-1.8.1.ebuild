# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Hedgedoc real-time collaborative markdown editor"
HOMEPAGE="https://hedgedoc.org/"
SRC_URI="https://github.com/hedgedoc/hedgedoc/releases/download/1.8.1/hedgedoc-1.8.1.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	acct-group/hedgedoc
	acct-user/hedgedoc
	net-libs/nodejs
	<sys-apps/yarn-2
"
DEPEND=""

S=${WORKDIR}/${PN}

RESTRICT="network-sandbox"

src_compile() {
	# Build steps from Dockerfile
	elog Fetching npm packages
	yarn install --production=true
	elog Building hedgedoc
	yarn run build
	#rm -rf node_modules
	# Production modules
	#yarn install --production=true
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
         -exec rm -rvf {} +
	rm public/uploads -rf
}

src_install() {
	insinto "/opt/hedgedoc"
	insopts -o hedgedoc -g hedgedoc -m 0664
	doins -r app.js package.json bin public lib locales node_modules
	# insopts doesn't affect directories.
	chown -R hedgedoc:hedgedoc "${ED}/opt/hedgedoc"
	chmod -R ug=rwX "${ED}/opt/hedgedoc"
	dodir /etc/hedgedoc
	insinto /etc/hedgedoc
	doins config.json.example
	dosym ${EPREFIX}/etc/hedgedoc/config.json ${EPREFIX}/opt/hedgedoc/config.json
	dodir /var/lib/hedgedoc
	dodir /var/lib/hedgedoc
	dodir /var/lib/hedgedoc/public
	keepdir /var/lib/hedgedoc/public/uploads
	dosym ${EPREFIX}/var/lib/hedgedoc/public/uploads ${EPREFIX}/opt/hedgedoc/public/uploads

	doinitd ${FILESDIR}/hedgedoc
}

pkg_postinst() {
	elog Feel free to copy /etc/hedgedoc/config.json.sample and tune it to suite your needs
	elog After that - run
	elog rc-service hedgedoc start
}
