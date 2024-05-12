# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11,12} )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1 pypi

DESCRIPTION="Hatch plugin to read pyproject.toml metadata from package.json"
HOMEPAGE="https://github.com/agoose77/hatch-nodejs-version"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

S=${WORKDIR}/hatch_nodejs_version-${PV}

distutils_enable_tests pytest
