# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11,12} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Telemetry for Jupyter Applications and extensions"
HOMEPAGE="https://github.com/jupyter/telemetry"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="\
	dev-python/ruamel-yaml[${PYTHON_USEDEP}] \
	dev-python/jsonschema[${PYTHON_USEDEP}] \
	dev-python/python-json-logger[${PYTHON_USEDEP}] \
	dev-python/traitlets[${PYTHON_USEDEP}] \
"
