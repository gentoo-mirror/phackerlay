# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DESCRIPTION="set of an OpenRC scripts to run mastodon services"

KEYWORDS="~amd64"

LICENSE="Artistic"
SLOT="0"

RDEPEND="
	sys-apps/openrc
"
src_prepare() {
	default
	S=${WORKDIR}
}


src_install() {
	newinitd "${FILESDIR}"/mastodon-web
	newinitd "${FILESDIR}"/mastodon-sidekiq
	newinitd "${FILESDIR}"/mastodon-streaming
	newconfd "${FILESDIR}"/mastodon
}

pkg_postinst() {
                elog
                elog "Please tune /etc/conf.d/mastodon to suite your needs, then "
		elog "cross your fingers and run:"
		elog
                elog "rc-service mastodon-sidekiq start"
                elog "rc-service mastodon-streaming start"
                elog "rc-service mastodon-web start"
                elog
		elog "Messages will be sent to syslog"
		elog
}
