# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12,13} )
inherit distutils-r1 pypi

DESCRIPTION="Easily report Python package versions and hardware resources"
HOMEPAGE="
	https://pypi.org/project/scooby/
	https://github.com/banesullivan/scooby
"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"