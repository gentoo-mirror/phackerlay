# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1 pypi

DESCRIPTION="nginx config file formatter/beautifier written in Python with no additional dependencies"
HOMEPAGE="https://github.com/slomkowski/nginx-config-formatter"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

