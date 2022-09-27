# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{9,10,11} )
CRATES="
	autocfg-1.1.0
	bitflags-1.3.2
	blake2-0.10.4
	block-buffer-0.10.3
	cfg-if-1.0.0
	crypto-common-0.1.6
	digest-0.10.5
	generic-array-0.14.6
	hex-0.4.3
	indoc-1.0.7
	libc-0.2.132
	lock_api-0.4.7
	once_cell-1.13.1
	parking_lot-0.12.1
	parking_lot_core-0.9.3
	proc-macro2-1.0.43
	pyo3-0.16.6
	pyo3-build-config-0.16.6
	pyo3-ffi-0.16.6
	pyo3-macros-0.16.6
	pyo3-macros-backend-0.16.6
	quote-1.0.21
	redox_syscall-0.2.16
	scopeguard-1.1.0
	smallvec-1.9.0
	subtle-2.4.1
	syn-1.0.99
	target-lexicon-0.12.4
	typenum-1.15.0
	unicode-ident-1.0.3
	unindent-0.1.10
	version_check-0.9.4
	windows-sys-0.36.1
	windows_aarch64_msvc-0.36.1
	windows_i686_gnu-0.36.1
	windows_i686_msvc-0.36.1
	windows_x86_64_gnu-0.36.1
	windows_x86_64_msvc-0.36.1
"

inherit distutils-r1 cargo

DESCRIPTION="Reference homeserver for the Matrix decentralised comms protocol"
HOMEPAGE="https://matrix.org/"

SRC_URI="https://github.com/matrix-org/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="postgres saml oidc ldap +redis"

distutils_enable_tests pytest

RDEPEND="
	acct-user/synapse
	acct-group/synapse
	>=dev-python/jsonschema-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/frozendict-1[${PYTHON_USEDEP}]
	!=dev-python/frozendict-2.1.2[${PYTHON_USEDEP}]
	>=dev-python/unpaddedbase64-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/canonicaljson-1.5.0[${PYTHON_USEDEP}]
	>=dev-python/signedjson-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/idna-2.5[${PYTHON_USEDEP}]
	>=dev-python/service_identity-18.1.0[${PYTHON_USEDEP}]
	>=dev-python/twisted-18.9.0[${PYTHON_USEDEP}]
	>=dev-python/treq-15.1[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-16.0.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.11[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-0.1.9[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-modules-0.0.7[${PYTHON_USEDEP}]
	>=dev-python/bcrypt-3.1.7[${PYTHON_USEDEP}]
	>=dev-python/pillow-4.3.0[jpeg,webp,${PYTHON_USEDEP}]
	>=dev-python/sortedcontainers-1.4.4[${PYTHON_USEDEP}]
	>=dev-python/pymacaroons-0.13.0[${PYTHON_USEDEP}]
	>=dev-python/msgpack-0.5.2[${PYTHON_USEDEP}]
	>=dev-python/phonenumbers-8.2.0[${PYTHON_USEDEP}]
	>=dev-python/prometheus_client-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/attrs-19.2.0[${PYTHON_USEDEP}]
	!=dev-python/attrs-21.1.0[${PYTHON_USEDEP}]
	>=dev-python/netaddr-0.7.18[${PYTHON_USEDEP}]
	>=dev-python/jinja-3.0[${PYTHON_USEDEP}]
	>=dev-python/bleach-1.4.3[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-3.10.0.1[${PYTHON_USEDEP}]
	>=dev-python/cryptography-3.4.7[${PYTHON_USEDEP}]
	>=dev-python/ijson-3.1.4[${PYTHON_USEDEP}]
	>=dev-python/matrix-common-1.3.0[${PYTHON_USEDEP}]
	<dev-python/matrix-common-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-16.1.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-1.7.4[${PYTHON_USEDEP}]
	>=dev-python/setuptools-rust-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/lxml-3.5.0[${PYTHON_USEDEP}]
	>=dev-python/sentry-sdk-0.7.2[${PYTHON_USEDEP}]
    >=dev-python/pyjwt-1.6.4[${PYTHON_USEDEP}]
	ldap? ( >=dev-python/matrix-synapse-ldap3-0.1[${PYTHON_USEDEP}] )
	postgres? ( >=dev-python/psycopg-2.8[${PYTHON_USEDEP}] <dev-python/psycopg-3[${PYTHON_USEDEP}] )
	saml? ( >=dev-python/pysaml2-4.5.0[${PYTHON_USEDEP}] )
	oidc? ( >=dev-python/authlib-0.14.0[${PYTHON_USEDEP}] )
	redis? ( dev-python/hiredis[${PYTHON_USEDEP}] >=dev-python/txredisapi-1.4.7[${PYTHON_USEDEP}] )
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
	newinitd "${FILESDIR}"/synapse.initd synapse
}

pkg_preinst() {
	keepdir /var/lib/synapse /etc/synapse
	fowners synapse:synapse /var/lib/synapse /etc/synapse
}

pkg_postinst() {
	if [ ! -e /etc/synapse/homeserver.yaml ]; then
		elog
		elog "For initial config run somewhat like"
		elog "sudo -u synapse python -m synapse.app.homeserver --server-name matrix.domain.tld --config-path /tmp/matrix.domain.tld.yaml --generate-config --report-stats=no"
		elog "Read https://github.com/matrix-org/synapse/blob/v${PV}/docs/setup/installation.md if interested in more"
		elog
	else
		elog "Please read upgrade instructions avaliable at https://github.com/matrix-org/synapse/blob/v${PV}/docs/upgrade.md"
		elog "And restart synapse afterwards"
	fi
}
