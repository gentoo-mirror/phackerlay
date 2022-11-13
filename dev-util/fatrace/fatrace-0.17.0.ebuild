# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools linux-info

SRC_URI="https://github.com/martinpitt/${PN}/archive/refs/tags/${PV}.tar.gz"
KEYWORDS="~amd64"

DESCRIPTION="report system wide file access events"
HOMEPAGE="https://github.com/martinpitt/fatrace"

LICENSE="GPL-3"
SLOT="0"

CONFIG_CHECK="
	~FANOTIFY
"

export PREFIX="/usr"
