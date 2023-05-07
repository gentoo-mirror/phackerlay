# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..11} )
inherit python-single-r1

DESCRIPTION="Meta package for Seafile Community Edition, file sync share solution"
HOMEPAGE="https://github.com/haiwen/seafile-server/ http://www.seafile.com/"
SRC_URI="https://s3.eu-central-1.amazonaws.com/download.seadrive.org/seafile-server_${PV}_x86-64.tar.gz"

LICENSE="seafile"
SLOT="0"
KEYWORDS="amd64"
IUSE="mysql oauth memcached"

RDEPEND="${PYTHON_DEPS}
	acct-user/seafile
	acct-group/seafile
	$(python_gen_cond_dep '
	=dev-python/future-0.18*[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/django-simple-captcha[${PYTHON_USEDEP}]

	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/django-pylibmc[${PYTHON_USEDEP}]
	dev-python/ldap3[${PYTHON_USEDEP}]
	=dev-python/pycryptodome-3.17*[${PYTHON_USEDEP}]
	~dev-python/cffi-1.15.1[${PYTHON_USEDEP}]
	=dev-python/django-3.2*[${PYTHON_USEDEP}]
	')

	oauth? (  $(python_gen_cond_dep ' dev-python/requests-oauthlib[${PYTHON_USEDEP}]') )
	memcached? (  $(python_gen_cond_dep ' dev-python/pylibmc[${PYTHON_USEDEP}]') )
	!mysql? (  $(python_gen_cond_dep '=dev-python/sqlalchemy-1.4.3[sqlite,${PYTHON_USEDEP}]') )
	mysql? (  $(python_gen_cond_dep '=dev-python/mysqlclient-2.1*[${PYTHON_USEDEP}] dev-python/pymysql[${PYTHON_USEDEP}]') )
	"
	#=dev-python/captcha-0.4*[${PYTHON_USEDEP}]
	#=dev-python/django-simple-captcha-0.5*[${PYTHON_USEDEP}]
	# see deletes from bundled below

DEPEND="${RDEPEND}"

src_unpack() {
	default
	S=${WORKDIR}/seafile-server-${PV}
}

src_prepare() {
	default
#	rm ${S}/seahub/thirdpart/cffi* -r
}

src_install() {
#	dolib.so ${FILESDIR}/libffi-806b1a9d.so.6.0.4
	insinto /opt/seafile
	doins -r ${WORKDIR}/seafile-server-${PV}
	chown -R seafile:seafile ${ED}/opt/seafile
	chmod +x ${ED}/opt/seafile/seafile-server-${PV}/seafile/bin/*
	chmod +x ${ED}/opt/seafile/seafile-server-${PV}/*.py
	chmod +x ${ED}/opt/seafile/seafile-server-${PV}/*.sh
	chmod +x ${ED}/opt/seafile/seafile-server-${PV}/seahub/thirdpart/bin/*
        newinitd "${FILESDIR}"/seafile.initd seafile
}

pkg_preinst() {
	keepdir /opt/seafile
}

pkg_postinst() {
	elog
	elog This ebuild just does mechanical work of unpacking and placing files to 
	elog desired '(by the program creator)' destinations
	elog
	elog If it is an upgrade, please look at
	elog https://manual.seafile.com/upgrade/upgrade/#upgrade-manual
	elog
	elog Otherwise, please follow either:
	elog https://manual.seafile.com/deploy/using_sqlite/#setting-up-seafile-server
	elog https://manual.seafile.com/deploy/using_mysql/#setting-up-seafile-ce
	elog
	elog 'All the actions should be done from seafile user:'
	elog su seafile -s /bin/bash
	elog
}
