# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="User for www-apps/seafile"

ACCT_USER_ID=-1
ACCT_USER_HOME="/opt/seafile"
ACCT_USER_GROUPS=( seafile )

acct-user_add_deps
