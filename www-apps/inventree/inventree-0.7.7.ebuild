# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9,10,11} )

inherit python-single-r1

DESCRIPTION="Open Source Inventory Management System"
HOMEPAGE="https://github.com/inventree/inventree"
SRC_URI="https://github.com/inventree/InvenTree/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+postgres"

RDEPEND="
	acct-user/inventree
	acct-group/inventree
	$(python_gen_cond_dep '
		dev-python/invoke[${PYTHON_USEDEP}]
	')
	$(python_gen_cond_dep '
		dev-python/venv[${PYTHON_USEDEP}]
	')
	$(python_gen_cond_dep '
		dev-python/pip[${PYTHON_USEDEP}]
	')
	postgres? ( dev-db/postgresql )
"

RESTRICT="network-sandbox"

S=${WORKDIR}/InvenTree-${PV}

src_install() {
	insinto /etc/inventree
	doins ${S}/InvenTree/config_template.yaml
	# ln -s ${EPREFIX}/etc/config.yaml ${EPREFIX}/inventree/src/InvenTree/config.yaml
	insinto /opt/inventree/src
	doins -r ${S}/InvenTree
	cd ${ED}/opt/inventree
	mkdir log static data
	chown -R inventree:inventree log static data
	${EPYTHON} -m venv venv
	venv/bin/python -m pip install -r ${S}/requirements.txt
	use postgres && venv/bin/python -m pip install psycopg2 || die
}

pkg_postinst() {
	if [ ! -e /opt/inventree/src/InvenTree/config.yaml ]; then
		elog
		elog	Please create /etc/inventree/config.yaml from template and
		elog	symlink it to /opt/inventree/src/InvenTree/
		elog	prior to execution
		elog
	fi
}
