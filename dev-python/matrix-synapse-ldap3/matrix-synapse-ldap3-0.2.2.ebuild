# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8,9,10,11} )
PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="An LDAP3 auth provider for Synapse "
HOMEPAGE="https://github.com/matrix-org/matrix-synapse-ldap3"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
    >=dev-python/twisted-15.1.0[${PYTHON_USEDEP}]
    >=dev-python/ldap3-2.8[${PYTHON_USEDEP}]
    dev-python/service-identity[${PYTHON_USEDEP}]
"

src_prepare() {
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
