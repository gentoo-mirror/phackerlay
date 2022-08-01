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
	app-admin/supervisor
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
	doins -r ${S}/*
	keepdir /opt/inventree/log
	keepdir /opt/inventree/static
	keepdir /opt/inventree/data
	cd ${ED}/opt/inventree
	chown -R inventree:inventree log static data src/InvenTree
	${EPYTHON} -m venv venv
	venv/bin/python -m pip install invoke wheel
	venv/bin/python -m pip install -r ${S}/requirements.txt --no-binary pillow || die
	use postgres && venv/bin/python -m pip install psycopg2 pgcli || die
	find ${ED}/opt/inventree/venv/bin -type f -exec sed -i "s:var/tmp/portage/www-apps/inventree-${PV}/image/::g" '{}' \;
	sed -i "s:/home/inventree:/opt/inventree:g" ${S}/deploy/supervisord.conf
	sed -i "s:inventree/env:inventree/venv:g" ${S}/deploy/supervisord.conf
	insinto /etc/supervisord.d
	newins ${S}/deploy/supervisord.conf inventree.conf
}

pkg_postinst() {
	if [ ! -f /opt/inventree/src/InvenTree/config.yaml ]; then
		elog
		elog	Please create /etc/inventree/config.yaml from template and
		elog	symlink it to /opt/inventree/src/InvenTree/
		elog	prior to execution
		elog
	fi
	elog
	elog	Beware, everything is experimental
	elog
	elog	su -s /bin/bash inventree
	elog	cd
	elog	. venv/bin/activate
	elog	cd src
	elog	invoke migrate
	elog	invoke translate_stat
	elog	invoke static
	elog	invoke clean_settings
	elog
	elog	rc-service supervisord restart
	elog
}
