# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="User for www-apps/hedgedoc"

ACCT_USER_ID=-1
ACCT_USER_HOME="/opt/hedgedoc"
ACCT_USER_GROUPS=( hedgedoc )

acct-user_add_deps
