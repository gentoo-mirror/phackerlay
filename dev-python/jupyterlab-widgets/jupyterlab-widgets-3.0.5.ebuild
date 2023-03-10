# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=jupyter
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="Jupyter interactive widgets for JupyterLab"
HOMEPAGE="
	https://ipywidgets.readthedocs.io/
	https://github.com/jupyter-widgets/ipywidgets/
	https://pypi.org/project/jupyterlab-widgets
"
SRC_URI="mirror://pypi/${PN:0:1}/jupyterlab_widgets/jupyterlab_widgets-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm arm64 hppa ~ia64 ~loong ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux"

RDEPEND="
	>=dev-python/ipywidgets-8[${PYTHON_USEDEP}]
	=dev-python/jupyterlab-3*[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/jsonschema[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

S=${WORKDIR}/jupyterlab_widgets-${PV}