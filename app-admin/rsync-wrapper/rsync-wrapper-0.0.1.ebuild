# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="rsync wrapper for running with rsnapshot"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	acct-user/backer
	acct-group/backer
	app-admin/sudo
	net-misc/rsync
"

S=${WORKDIR}

src_install() {
	dobin "${FILESDIR}"/rsync-wrapper.sh
	insinto /etc/sudoers.d
	newins "${FILESDIR}"/backer.sudoers backer
}
