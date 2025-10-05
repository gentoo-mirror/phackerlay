# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

POSTGRES_COMPAT=( {16..18} )
POSTGRES_USEDEP="server"

inherit postgres-multi autotools

DESCRIPTION="PGroonga is a PostgreSQL extension to use Groonga as index"
HOMEPAGE="
	https://pgroonga.github.io/
	https://github.com/pgroonga/pgroonga
"
SRC_URI="https://github.com/pgroonga/pgroonga/releases/download/${PV}/pgroonga-${PV}.tar.gz"

LICENSE="POSTGRESQL"

BDEPEND="
	app-text/groonga
	dev-libs/msgpack
"

RDEPEND="
	${POSTGRES_DEP}
"


DEPEND="
	${BDEPEND}
	${RDEPEND}
"

SLOT="0"
KEYWORDS="~amd64"
