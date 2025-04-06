# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGO_PN="oauth2-proxy"
inherit go-module

DESCRIPTION="A reverse proxy that provides authentication with Google, Azure, OpenID Connect and many more identity providers"
HOMEPAGE="https://github.com/oauth2-proxy/oauth2-proxy"
SRC_URI="
	https://github.com/oauth2-proxy/oauth2-proxy/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.phys-el.ru/gentoo/phackerlay/-/raw/master/distfiles/${P}-deps.tar.xz
"

BDEPEND="
	>=dev-lang/go-1.19
"

LICENSE="MIT BSD BSD-2 Apache-2.0 ISC"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	unset LDFLAGS
	emake build
}

src_install() {
	dobin ${S}/oauth2-proxy
}

#PV=7.8.2
#wget https://github.com/oauth2-proxy/oauth2-proxy/archive/refs/tags/v$PV.tar.gz
#tar -xf v$PV.tar.gz
#rm v$PV.tar.gz
#cd oauth2-proxy-$PV/
#GOMODCACHE="${PWD}"/go-mod go mod download -modcacherw
#XZ_OPT='-T0 -9' tar -acf oauth2-proxy-$PV-deps.tar.xz go-mod
#mv oauth2-proxy-$PV-deps.tar.xz ../../distfiles/
