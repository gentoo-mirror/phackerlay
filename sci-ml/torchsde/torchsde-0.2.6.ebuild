# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1 pypi

DESCRIPTION="Differentiable SDE solvers with GPU support and efficient sensitivity analysis"
HOMEPAGE="https://github.com/google-research/torchsde"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=sci-ml/pytorch-1.6[${PYTHON_SINGLE_USEDEP}]
	$(python_gen_cond_dep '
		>=dev-python/numpy-1.19[${PYTHON_USEDEP}]
		>=dev-python/scipy-1.5[${PYTHON_USEDEP}]
		>=dev-python/trampoline-0.1.2[${PYTHON_USEDEP}]
	')
"
