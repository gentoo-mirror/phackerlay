# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A community-driven, freely-licensed binary distribution of Microsoft's VSCode"
HOMEPAGE="https://vscodium.com/"
SRC_URI="
	amd64? ( https://github.com/VSCodium/vscodium/releases/download/${PV}/vscodium-reh-linux-x64-${PV}.tar.gz -> ${P}-amd64.tar.gz )
	arm64? ( https://github.com/VSCodium/vscodium/releases/download/${PV}/vscodium-reh-linux-arm64-${PV}.tar.gz -> ${P}-arm64.tar.gz )
"
#	arm? ( https://github.com/VSCodium/vscodium/releases/download/${PV}/vscodium-reh-linux-armhf-${PV}.tar.gz -> ${P}-arm.tar.gz )

LICENSE="
	Apache-2.0
	BSD
	BSD-1
	BSD-2
	BSD-4
	CC-BY-4.0
	ISC
	LGPL-2.1+
	MIT
	MPL-2.0
	openssl
	PYTHON
	TextMate-bundle
	Unlicense
	UoI-NCSA
	W3C
"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"
IUSE=""

RDEPEND="
	<net-libs/nodejs-18
"


S="${WORKDIR}"

src_install() {
	rm node
	insinto "/opt/${PN}"
	sed -i 's:$ROOT/node:node:g' bin/codium-server
	sed -i 's:$ROOT/out:'"/opt/${PN}/out:g" bin/codium-server
	sed -i 's:"$@":--telemetry-level off "$@":g' bin/codium-server

	# ROOT="$(dirname "$(dirname "$(readlink -f "$0")")")"
	# "$ROOT/node" ${INSPECT:-} "$ROOT/out/server-main.js" "$@"

	doins -r *
	fperms +x /opt/${PN}/bin/codium-server
#	fperms +x /opt/${PN}/node_modules/node-pty/build/Release/spawn-helper
	fperms +x /opt/${PN}/node_modules/@vscode/ripgrep/bin/rg
	dosym "../../opt/${PN}/bin/codium-server" "usr/bin/codium-server"
	dosym "../../opt/${PN}/bin/codium-server" "usr/bin/vscodium-server"
}

pkg_postinst() {
	elog "Read about usage at https://github.com/xaberus/vscode-remote-oss"
}
