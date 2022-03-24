# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for app-admin/rsync-wrapper"

ACCT_USER_ID=-1
ACCT_USER_HOME="/var/lib/backer"
ACCT_USER_GROUPS=( backer )
ACCT_USER_SHELL=/bin/sh

acct-user_add_deps
