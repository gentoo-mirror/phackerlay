# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11} )

inherit distutils-r1

DESCRIPTION="Trame lets you weave various components and technologies into a Web Application solely written in Python"
HOMEPAGE="https://github.com/Kitware/trame"

SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
    >=dev-python/trame-server-2.11.0[${PYTHON_USEDEP}]
    >=dev-python/trame-client-2.1.0[${PYTHON_USEDEP}]
    =dev-python/trame-router-2.0.1[${PYTHON_USEDEP}]
    =dev-python/trame-components-2.1.0[${PYTHON_USEDEP}]
    =dev-python/trame-plotly-2.1.0[${PYTHON_USEDEP}]
    =dev-python/trame-markdown-2.0.2[${PYTHON_USEDEP}]
    =dev-python/trame-matplotlib-2.0.1[${PYTHON_USEDEP}]
    =dev-python/trame-deckgl-2.0.1[${PYTHON_USEDEP}]
    =dev-python/trame-vega-2.0.2[${PYTHON_USEDEP}]
    <dev-python/trame-vuetify-3.0.0[${PYTHON_USEDEP}]
    <dev-python/trame-vtk-3.0.0[${PYTHON_USEDEP}]
    <dev-python/trame-simput-3.0.0[${PYTHON_USEDEP}]
    <dev-python/trame-rca-3.0.0[${PYTHON_USEDEP}]
"

