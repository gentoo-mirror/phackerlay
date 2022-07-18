# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8


PYTHON_COMPAT=( python3_{9,10,11} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

SRC_URI="https://gitlab.phys-el.ru/soft-aware/sendr4d4/-/archive/v${PV}/sendr4d4-v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="drop in sendmail replacement to redirect system mail to r4d4 api"
HOMEPAGE="https://gitlab.phys-el.ru/soft-aware/sendr4d4"

LICENSE="MIT"
SLOT="0"
IUSE="+mta"

RDEPEND="
	dev-python/toml
	dev-python/requests
	net-mail/mailbase
	mta? (
		!mail-mta/courier
		!mail-mta/esmtp
		!mail-mta/exim
		!mail-mta/mini-qmail
		!mail-mta/msmtp[mta]
		!mail-mta/netqmail
		!mail-mta/nullmailer
		!mail-mta/postfix
		!mail-mta/qmail-ldap
		!mail-mta/sendmail
		!mail-mta/ssmtp
		!mail-mta/opensmtpd
	)
"

RESTRICT="test"

S="${WORKDIR}/sendr4d4-v${PV}"

python_install() {
        distutils-r1_python_install --skip-build
	if use mta; then
		dosym ../bin/sendr4d4 /usr/lib/sendmail
		dosym ../bin/sendr4d4 /usr/sbin/sendmail
		dosym ../bin/sendr4d4 /usr/bin/sendmail
		dosym ../bin/sendr4d4 /usr/bin/mailq
		dosym ../bin/sendr4d4 /usr/bin/newaliases
	fi
}
