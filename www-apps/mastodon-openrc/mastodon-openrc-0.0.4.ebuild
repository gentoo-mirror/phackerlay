# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DESCRIPTION="a set of an OpenRC scripts to run mastodon services"

KEYWORDS="~amd64"

LICENSE="Artistic"
SLOT="0"

RDEPEND="
	sys-apps/openrc
"
src_unpack() {
	default
	S=${WORKDIR}
}


src_install() {
	newinitd "${FILESDIR}"/mastodon-all mastodon
	doinitd "${FILESDIR}"/mastodon-web
	doinitd "${FILESDIR}"/mastodon-sidekiq
	doinitd "${FILESDIR}"/mastodon-streaming
	doconfd "${FILESDIR}"/mastodon
}

pkg_postinst() {
                elog
                elog "Please tune /etc/conf.d/mastodon to suite your needs, then "
		elog "cross your fingers and run:"
		elog
                elog "rc-service mastodon-web start"
                elog "rc-service mastodon-streaming start"
                elog "rc-service mastodon-sidekiq start"
                elog
                elog
                elog "All services could be restarted with:"
		elog
                elog "rc-service mastodon restart"
		elog
		elog
		elog "All messages will be sent to syslog"
		elog
}
