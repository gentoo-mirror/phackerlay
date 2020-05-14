# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="A multi-user server for Jupyter notebooks"
HOMEPAGE="https://github.com/jupyterhub/jupyterhub"
SRC_URI="https://github.com/jupyterhub/jupyterhub/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+ldapauthenticator"

RESTRICT=network-sandbox

#dev-libs/kpathsea no mpl plots

RDEPEND="\
	dev-python/async_generator \
	dev-python/entrypoints \
	dev-python/alembic \
	>=dev-python/async_generator-1.8 \
	>=dev-python/certipy-0.1.2 \
	dev-python/entrypoints \
	>=dev-python/jinja-2 \
	dev-python/jupyter-telemetry \
	>=dev-python/oauthlib-3.0 \
	dev-python/pamela \
	>=dev-python/prometheus_client-0.0.21 \
	dev-python/python-dateutil \
	dev-python/requests \
	>=dev-python/sqlalchemy-1.1 \
	>=www-servers/tornado-5.0 \
	>=dev-python/traitlets-4.3.2 \
	dev-python/jupyter \
	ldapauthenticator? ( dev-python/jupyterhub-ldapauthenticator ) \
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
	distutils-r1_python_install_all
}
