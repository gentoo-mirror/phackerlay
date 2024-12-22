# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A community-driven, freely-licensed binary distribution of Microsoft's VSCode"
HOMEPAGE="https://vscodium.com/"
SRC_URI="
	amd64? ( https://github.com/VSCodium/vscodium/releases/download/${PV}/vscodium-reh-linux-x64-${PV}.tar.gz -> ${P}-amd64.tar.gz )
	arm64? ( https://github.com/VSCodium/vscodium/releases/download/${PV}/vscodium-reh-linux-arm64-${PV}.tar.gz -> ${P}-arm64.tar.gz )
"

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
SLOT="${PV}"
KEYWORDS="-* ~amd64 ~arm64"
IUSE=""

RESTRICT="strip"
QA_PREBUILT="opt/${PN}/${P}/*"

S="${WORKDIR}"

src_install() {
	# rm node # 20240721 still is built with node-16 and started failing with 18
	insinto "/opt/${PN}/${P}"
	sed -i 's:$ROOT/node:'"/opt/${PN}/${P}/node:g" bin/codium-server
	sed -i 's:$ROOT/out:'"/opt/${PN}/${P}/out:g" bin/codium-server
	sed -i 's:"$@":--telemetry-level off --host 127.0.0.1 "$@":g' bin/codium-server

	find ${S} -name '*.js' -exec chmod +x '{}' \;

	doins -r *
	fperms +x /opt/${PN}/${P}/node
	fperms +x /opt/${PN}/${P}/bin/codium-server
	fperms +x /opt/${PN}/${P}/node_modules/@vscode/ripgrep/bin/rg
	dosym "../../../opt/${PN}/${P}/bin/codium-server" "usr/bin/${P}"
	dosym "../../../opt/${PN}/${P}/bin/codium-server" "usr/bin/${P}"
}

pkg_postinst() {
	elog "Read about usage at https://github.com/xaberus/vscode-remote-oss"
}
