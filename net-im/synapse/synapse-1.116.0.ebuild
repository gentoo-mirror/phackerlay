# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DISTUTILS_USE_PEP517=poetry
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{11,12} )
CRATES="
	aho-corasick-1.1.3
	anyhow-1.0.89
	arc-swap-1.7.1
	autocfg-1.3.0
        base64-0.21.7
	bitflags-2.5.0
	blake2-0.10.6
	block-buffer-0.10.4
	bytes-1.7.2
	bumpalo-3.16.0
	cfg-if-1.0.0
	fnv-1.0.7
	crypto-common-0.1.6
	cpufeatures-0.2.12
	digest-0.10.7
	generic-array-0.14.7
	getrandom-0.2.15
        heck-0.4.1
	hex-0.4.3
	headers-0.4.0
	headers-core-0.3.0
	http-1.1.0
	httpdate-1.0.3
	indoc-2.0.5
	itoa-1.0.11
	js-sys-0.3.69
	lazy_static-1.5.0
	libc-0.2.154
	lock_api-0.4.12
	log-0.4.22
	memchr-2.7.2
	memoffset-0.9.1
	mime-0.3.17
	once_cell-1.19.0
	parking_lot-0.12.2
	parking_lot_core-0.9.10
        portable-atomic-1.6.0
	proc-macro2-1.0.82
	pyo3-0.21.2
	pyo3-build-config-0.21.2
	pyo3-ffi-0.21.2
	pyo3-log-0.10.0
	pyo3-macros-0.21.2
	pyo3-macros-backend-0.21.2
	pythonize-0.21.1
	ppv-lite86-0.2.17
	quote-1.0.36
	redox_syscall-0.5.1
	regex-1.10.6
	regex-syntax-0.8.3
	regex-automata-0.4.6
	rand-0.8.5
	rand_chacha-0.3.1
	rand_core-0.6.4
	ryu-1.0.18
	scopeguard-1.2.0
	serde-1.0.210
	serde_derive-1.0.210
	serde_json-1.0.128
	smallvec-1.13.2
	subtle-2.5.0
	syn-2.0.61
	sha1-0.10.6
	sha2-0.10.8
	target-lexicon-0.12.14
	typenum-1.17.0
	unicode-ident-1.0.12
	unindent-0.2.3
	ulid-1.1.3
	version_check-0.9.4
	wasi-0.11.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.92
	wasm-bindgen-backend-0.2.92
	wasm-bindgen-macro-0.2.92
	wasm-bindgen-macro-support-0.2.92
	wasm-bindgen-shared-0.2.92
	web-time-1.1.0
	windows-sys-0.52.0
	windows-targets-0.52.5
	windows_aarch64_msvc-0.52.5
	windows_aarch64_gnullvm-0.52.5
	windows_i686_gnu-0.52.5
	windows_i686_gnullvm-0.52.5
	windows_i686_msvc-0.52.5
	windows_x86_64_gnu-0.52.5
	windows_x86_64_gnullvm-0.52.5
	windows_x86_64_msvc-0.52.5
"

inherit cargo distutils-r1

DESCRIPTION="Reference homeserver for the Matrix decentralised comms protocol"
HOMEPAGE="https://matrix.org/"

SRC_URI="
	https://github.com/element-hq/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})
"
KEYWORDS="~amd64"

LICENSE="AGPL-3+"
SLOT="0"
IUSE="postgres saml oidc ldap +redis"

distutils_enable_tests pytest

RDEPEND="
	acct-user/synapse
	acct-group/synapse
	>=dev-python/jsonschema-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/immutabledict-2[${PYTHON_USEDEP}]
	>=dev-python/unpaddedbase64-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/canonicaljson-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/signedjson-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/idna-2.5[${PYTHON_USEDEP}]
	>=dev-python/service-identity-18.1.0[${PYTHON_USEDEP}]
	>=dev-python/twisted-18.9.0[${PYTHON_USEDEP}]
	>=dev-python/treq-15.1[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-16.0.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.13[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-0.1.9[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-modules-0.0.7[${PYTHON_USEDEP}]
	>=dev-python/bcrypt-3.1.7[${PYTHON_USEDEP}]
	>=dev-python/pillow-10.0.1[jpeg,webp,${PYTHON_USEDEP}]
	>=dev-python/sortedcontainers-1.4.4[${PYTHON_USEDEP}]
	>=dev-python/pymacaroons-0.13.0[${PYTHON_USEDEP}]
	>=dev-python/msgpack-0.5.2[${PYTHON_USEDEP}]
	>=dev-python/phonenumbers-8.2.0[${PYTHON_USEDEP}]
	>=dev-python/prometheus-client-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/attrs-19.2.0[${PYTHON_USEDEP}]
	!=dev-python/attrs-21.1.0[${PYTHON_USEDEP}]
	>=dev-python/netaddr-0.7.18[${PYTHON_USEDEP}]
	>=dev-python/jinja-3.0[${PYTHON_USEDEP}]
	>=dev-python/bleach-1.4.3[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/cryptography-43.0.1[${PYTHON_USEDEP}]
	>=dev-python/ijson-3.1.4[${PYTHON_USEDEP}]
	>=dev-python/matrix-common-1.3.0[${PYTHON_USEDEP}]
	<dev-python/matrix-common-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-16.1.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-1.7.4[${PYTHON_USEDEP}]
	<dev-python/pydantic-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/setuptools-rust-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/lxml-3.5.0[${PYTHON_USEDEP}]
	>=dev-python/sentry-sdk-0.7.2[${PYTHON_USEDEP}]
    >=dev-python/pyjwt-1.6.4[${PYTHON_USEDEP}]
	>=dev-python/pyicu-2.10.2[${PYTHON_USEDEP}]
	>=dev-python/python-multipart-0.0.9[${PYTHON_USEDEP}]
	ldap? ( >=dev-python/matrix-synapse-ldap3-0.1[${PYTHON_USEDEP}] )
	postgres? ( >=dev-python/psycopg-2.8[${PYTHON_USEDEP}] <dev-python/psycopg-3[${PYTHON_USEDEP}] )
	saml? ( >=dev-python/pysaml2-4.5.0[${PYTHON_USEDEP}] )
	oidc? ( || ( >=dev-python/authlib-0.15.1[${PYTHON_USEDEP}] >=dev-python/Authlib-0.15.1[${PYTHON_USEDEP}] ) )
	redis? ( dev-python/hiredis[${PYTHON_USEDEP}] >=dev-python/txredisapi-1.4.7[${PYTHON_USEDEP}] )
"
DEPEND="${RDEPEND}"

src_unpack() {
	cargo_src_unpack
	default
}

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
