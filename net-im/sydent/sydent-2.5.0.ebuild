# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

PYTHON_COMPAT=( python3_{6,7,8,9} )
inherit distutils-r1

DESCRIPTION="Reference Matrix Identity Verification and Lookup Server"
HOMEPAGE="https://matrix.org/"

SRC_URI="https://github.com/matrix-org/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="Apache-2.0"
SLOT="0"

PATCHES=( "${FILESDIR}/01_remove_tests.patch" )

RDEPEND="
	acct-user/sydent
	acct-group/sydent
	>=dev-python/jinja-3.0[${PYTHON_USEDEP}]
	>=dev-python/signedjson-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/unpaddedbase64-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/twisted-18.4.0[${PYTHON_USEDEP}]
	>=dev-python/service_identity-18.1.0[${PYTHON_USEDEP}]
	dev-python/pyopenssl
	>=dev-python/attrs-19.1.0[${PYTHON_USEDEP}]
	>=dev-python/netaddr-0.7.0[${PYTHON_USEDEP}]
	>=dev-python/sortedcontainers-1.4.4[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.11[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

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
	newinitd "${FILESDIR}"/sydent.initd sydent
}

pkg_preinst() {
	keepdir /etc/synapse /var/lib/sydent
	fowners sydent:sydent /etc/synapse /var/lib/sydent
}
