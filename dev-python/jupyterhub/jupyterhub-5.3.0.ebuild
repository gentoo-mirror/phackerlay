# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12,13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="A multi-user server for Jupyter notebooks"
HOMEPAGE="https://github.com/jupyterhub/jupyterhub"
SRC_URI="https://github.com/jupyterhub/jupyterhub/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="ldapauthenticator postgres sudospawner"

RESTRICT=network-sandbox

PATCHES=(
	${FILESDIR}/01_alembic.patch
)

distutils_enable_tests pytest

RDEPEND="
	acct-user/jupyterhub
	acct-group/jupyterhub
	net-libs/nodejs[npm]
	>=dev-python/alembic-1.4[${PYTHON_USEDEP}]
	>=dev-python/certipy-0.1.2[${PYTHON_USEDEP}]
	dev-python/idna[${PYTHON_USEDEP}]
	>=dev-python/jinja2-2.11.0[${PYTHON_USEDEP}]
	dev-python/jupyter-events[${PYTHON_USEDEP}]
	>=dev-python/oauthlib-3.0[${PYTHON_USEDEP}]
	dev-python/pamela[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	>=dev-python/prometheus-client-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.0.0[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-1.4.1[${PYTHON_USEDEP}]
	>=dev-python/tornado-5.1[${PYTHON_USEDEP}]
	>=dev-python/traitlets-4.3.2[${PYTHON_USEDEP}]
	|| ( dev-python/jupyterlab[${PYTHON_USEDEP}] dev-python/jupyter[${PYTHON_USEDEP}] )
	postgres? ( <dev-python/psycopg-3[${PYTHON_USEDEP}] )
	ldapauthenticator? ( dev-python/jupyterhub-ldapauthenticator[${PYTHON_USEDEP}] )
	sudospawner? ( dev-python/sudospawner[${PYTHON_USEDEP}] )
"

src_prepare() {
        einfo
        einfo 'Note, allowing network access from the sandbox via RESTRICT=network-sandbox'
        einfo '(needed for building jupyterhub assets via npm)'
        einfo
	distutils-r1_src_prepare
}

python_compile() {
	distutils-r1_python_compile
}

python_install() {
        distutils-r1_python_install --skip-build
}

python_install_all() {
	cd ${S} && python -m jupyterhub --generate-config || die
	insinto /etc/jupyterhub
	newins ${S}/jupyterhub_config.py config.example.py
	newinitd "${FILESDIR}"/jupyterhub.initd jupyterhub
	distutils-r1_python_install_all
	rm ${D}/usr/alembic.ini
}

pkg_preinst() {
	keepdir /var/lib/jupyterhub
	fowners jupyterhub:jupyterhub /var/lib/jupyterhub
}
pkg_postinst() {
        if [ ! -e /etc/jupyterhub/config.py ]; then
                elog
                elog "Please cp /etc/jupyterhub/config.example.py /etc/jupyterhub/config.py"
                elog "And tune it to your needs"
                elog
        else
                elog
                elog "May be it is good idea to compare working config with example one"
                elog "diff /etc/jupyterhub/config.example.py /etc/jupyterhub/config.py"
		elog "and see the changelog at https://jupyterhub.readthedocs.io/en/${PV}/changelog.html"
                elog
        fi
}
