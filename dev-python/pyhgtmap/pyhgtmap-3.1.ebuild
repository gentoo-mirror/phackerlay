# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10,11} )

inherit distutils-r1 pypi

DESCRIPTION="Little program which lets you easily generate OSM contour lines"
HOMEPAGE="http://katze.tfiu.de/projects/phyghtmap/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	>=dev-python/colorlog-6.7.0[${PYTHON_USEDEP}]
	>=dev-python/contourpy-1.0.7[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-3.4.3[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.24.2[${PYTHON_USEDEP}]
	>=dev-python/npyosmium-3.6.1[${PYTHON_USEDEP}]
	>=dev-python/pybind11-rdp-0.1.3[${PYTHON_USEDEP}]
	>=dev-python/scipy-1.8.0[${PYTHON_USEDEP}]
	>=dev-python/shapely-2.0.1[${PYTHON_USEDEP}]
"

