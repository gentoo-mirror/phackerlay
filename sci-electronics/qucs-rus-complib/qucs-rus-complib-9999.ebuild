# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/ra3xdh/qucs-rus-complib.git"
EGIT_BRANCH="master"

inherit git-r3

PROPERTIES="live"

DESCRIPTION="Russian components library for Qucs"
HOMEPAGE="https://github.com/ra3xdh/qucs-rus-complib"
KEYWORDS=""
LICENSE="GPL-2"
SLOT="0"
IUSE=""
DEPEND="sci-electronics/qucs-s"

src_prepare() {
	default
	rm ${S}/.gitignore
	rm ${S}/COPYING
	rm ${S}/README.md
}

src_install() {
	insinto /usr/share/qucs-s/library
	doins -r ${S}/*
}
