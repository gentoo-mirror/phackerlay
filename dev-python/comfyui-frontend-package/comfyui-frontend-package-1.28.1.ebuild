# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1 pypi

DESCRIPTION="Pypi package structure for the comfyui frontend"
HOMEPAGE="https://pypi.org/project/comfyui-frontend-package"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

