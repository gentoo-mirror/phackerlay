# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Open-source version of the fonts by Russian standard GOST 2.304-81"
HOMEPAGE="https://fontstorage.com/font/nikita-volchenkov/opengost-a"
SRC_URI="https://fonts.fontstorage.com/fonts/original/opengosta/opengosta.zip -> opengost-a.zip"
S="${WORKDIR}"

LICENSE="OFL-1.10"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

DEPEND="app-arch/unzip"

FONT_SUFFIX="ttf"
