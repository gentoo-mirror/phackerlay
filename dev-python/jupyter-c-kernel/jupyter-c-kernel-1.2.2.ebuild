# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1 pypi

DESCRIPTION="Minimal Jupyter C kernel"
HOMEPAGE="
	https://github.com/brendan-rius/jupyter-c-kernel
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests pytest

S=${WORKDIR}/jupyter_c_kernel-${PV}

python_install_all() {
        distutils-r1_python_install_all
	insinto /usr/share/jupyter/kernels/c
	doins ${FILESDIR}/kernel.json
	doins ${FILESDIR}/logo-32x32.png
	doins ${FILESDIR}/logo-64x64.png
	doins ${FILESDIR}/logo-svg.svg
}
