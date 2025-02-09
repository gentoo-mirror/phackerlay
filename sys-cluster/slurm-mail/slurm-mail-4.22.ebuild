# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12,13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="A drop in replacement for Slurm's e-mails"
HOMEPAGE="https://github.com/neilmunday/slurm-mail"
SRC_URI="https://github.com/neilmunday/slurm-mail/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	acct-user/slurm
	acct-group/slurm
"

DEPEND="
	${BDEPEND}
"

python_install_all() {
	# fix installing to in PEP517 /usr/lib/python3.12/site-packages/etc/slurm-mail
        distutils-r1_python_install_all
	mv ${D}/${PORTAGE_PYM_PATH}/etc ${D}/

	keepdir /var/{spool,log}/slurm-mail
	fowners slurm:slurm /var/spool/slurm-mail
	fowners slurm:slurm /var/log/slurm-mail
}
