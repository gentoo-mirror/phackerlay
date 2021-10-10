# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="user for apcupsd_exporter"

ACCT_USER_ID=-1
ACCT_USER_HOME="/var/lib/apcupsd_exporter"
ACCT_USER_GROUPS=( apcupsd_exporter )

acct-user_add_deps
