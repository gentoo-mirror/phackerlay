# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11} )

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


src_unpack() {
	default
	mv * ${P}
}

src_prepare() {
	distutils-r1_src_prepare
}

python_compile() {
	distutils-r1_python_compile
}

python_install() {
	distutils-r1_python_install --skip-build
}

python_install_all() {
	distutils-r1_python_install_all
}
