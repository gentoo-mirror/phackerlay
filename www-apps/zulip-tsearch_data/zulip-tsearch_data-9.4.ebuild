# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

POSTGRES_COMPAT=( {16..17} )
POSTGRES_USEDEP="server"

inherit postgres-multi

DESCRIPTION="Files for using zulip with upstream postgresql"
HOMEPAGE="https://github.com/zulip/zulip"

SRC_URI="https://github.com/zulip/zulip/releases/download/${PV}/zulip-server-${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/zulip-server-${PV}"
KEYWORDS="~amd64"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

REQUIRED_USE="${POSTGRES_REQ_USE}"

RDEPEND="
	${POSTGRES_DEP}
        app-dicts/myspell-en[L10N_en-US]
	dev-db/pgroonga
"

src_compile() {
	:
}

src_install() {
	pg_install() {
		insinto /usr/share/postgresql-${PG_SLOT}/tsearch_data
		doins ${S}/puppet/zulip/files/postgresql/zulip_english.stop
	}

	postgres-multi_foreach pg_install
	postgres-multi_foreach dosym "/usr/share/hunspell/en_US.dic" "${EPREFIX}/usr/share/postgresql-${PG_SLOT}/tsearch_data/en_us.dict"
	postgres-multi_foreach dosym "/usr/share/hunspell/en_US.aff" "${EPREFIX}/usr/share/postgresql-${PG_SLOT}/tsearch_data/en_us.affix"
}
