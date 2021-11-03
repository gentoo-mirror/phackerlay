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

distutils_enable_tests pytest

PATCHES="${FILESDIR}/01_remove_tests.patch
	 ${FILESDIR}/02_sydent_exec.patch"

RDEPEND="
	acct-user/sydent
	acct-group/sydent
	>=dev-python/jinja-3.0[${PYTHON_USEDEP}]
	>=dev-python/signedjson-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/unpaddedbase64-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/twisted-18.4.0[${PYTHON_USEDEP}]
	>=dev-python/service_identity-18.1.0[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	>=dev-python/attrs-19.1.0[${PYTHON_USEDEP}]
	>=dev-python/netaddr-0.7.0[${PYTHON_USEDEP}]
	>=dev-python/sortedcontainers-1.4.4[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.11[${PYTHON_USEDEP}]
	dev-python/phonenumbers[${PYTHON_USEDEP}]
        >=dev-python/frozendict-1[${PYTHON_USEDEP}]
	>=dev-python/canonicaljson-1.4.0[${PYTHON_USEDEP}]
	dev-python/importlib_metadata
"
DEPEND="${RDEPEND}"

src_prepare() {
        distutils-r1_src_prepare
}

python_compile() {
        distutils-r1_python_compile
}

python_install() {
	cd ${S} && python -c 'from sydent.sydent import *; SydentConfig().parse_config_file(get_config_file_path())'
	sed -i 's:res:/etc/sydent/templates:g' ${S}/sydent.conf
        distutils-r1_python_install --skip-build
}

python_install_all() {
	distutils-r1_python_install_all
	newinitd "${FILESDIR}"/sydent.initd sydent
	insinto /etc/sydent
	newins ${S}/sydent.conf sydent.conf.example
	insinto /etc/sydent/templates
	doins -r ${S}/res/matrix-org
}

pkg_preinst() {
	keepdir /var/lib/sydent /var/run/sydent
	fowners sydent:sydent /var/lib/sydent /var/run/sydent
}
pkg_postinst() {
        if [ ! -e /etc/sydent/sydent.conf ]; then
                elog
                elog "Please cp /etc/sydent/sydent.conf.example /etc/sydent/sydent.conf"
                elog "And tune it to your needs"
                elog "Note that all of keys of config, as it may seem, should be transferred"
		elog "from DEFAULT to other relevant section of config (strange idea, yes?)"
                elog
        else
                elog "May be it is good idea to compare working config with example one"
                elog "diff /etc/sydent/sydent.conf.example /etc/sydent/sydent.conf"
        fi
        if [ ! -e /etc/sydent/templates/verification_template.eml ]; then
                elog
                elog "Also please cp /etc/sydent/templates/matrix-org/* /etc/sydent/templates/"
                elog "And tune them to your needs"
                elog
        fi
}
