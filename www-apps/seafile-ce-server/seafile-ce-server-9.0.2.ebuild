# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{9..10} )
inherit python-single-r1

DESCRIPTION="Meta package for Seafile Community Edition, file sync share solution"
HOMEPAGE="https://github.com/haiwen/seafile-server/ http://www.seafile.com/"
SRC_URI="https://s3.eu-central-1.amazonaws.com/download.seadrive.org/seafile-server_${PV}_x86-64.tar.gz"

LICENSE="seafile"
SLOT="0"
KEYWORDS="amd64"
IUSE="mysql oauth"

RDEPEND="${PYTHON_DEPS}
	acct-user/seafile
	acct-group/seafile
	$(python_gen_cond_dep '
	dev-python/future[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pylibmc[${PYTHON_USEDEP}]
	dev-python/django-simple-captcha[${PYTHON_USEDEP}]

	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/django-pylibmc[${PYTHON_USEDEP}]
	dev-python/ldap3[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/cffi[${PYTHON_USEDEP}]
	=dev-python/django-3.2*[${PYTHON_USEDEP}]
	')

	oauth? (  $(python_gen_cond_dep ' dev-python/requests-oauthlib[${PYTHON_USEDEP}]') )
	!mysql? (  $(python_gen_cond_dep 'dev-python/sqlalchemy[sqlite,${PYTHON_USEDEP}]') )
	mysql? (  $(python_gen_cond_dep ' dev-python/mysqlclient[${PYTHON_USEDEP}]') )
	"
DEPEND="${RDEPEND}"

src_unpack () {
	default
	S=${WORKDIR}/seafile-server-${PV}
}

src_install() {
	dolib.so ${FILESDIR}/libffi-806b1a9d.so.6.0.4
	insinto /opt/seafile
	doins -r ${WORKDIR}/seafile-server-${PV}
	chown -R seafile:seafile ${ED}/opt/seafile
        newinitd "${FILESDIR}"/seafile.initd seafile
}

pkg_preinst() {
        fowners seafile:seafile /opt/seafile
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
}
