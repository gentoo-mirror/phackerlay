# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="prog user for fs"

ACCT_USER_ID=-1
ACCT_USER_HOME="/usr2/prog"
ACCT_USER_GROUPS=( prog )
ACCT_USER_NO_MODIFY=1

acct-user_add_deps
