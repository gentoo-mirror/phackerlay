# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 git-r3

DESCRIPTION="Interactive C++ interpreter, built on the top of LLVM and Clang libraries"
HOMEPAGE="https://root.cern/cling/"

EGIT_OVERRIDE_REPO_CLING="http://root.cern/git/cling.git"

LICENSE="Apache-2.0" # more
SLOT="0"
KEYWORDS="~amd64"
IUSE="-cpp11 -cpp14 cpp17 -cpp1z"
RESTRICT="mirror"

DEPEND="
	=dev-cpp/cling-${PV}
	dev-python/ipykernel[${PYTHON_USEDEP}]
	dev-python/traitlets[${PYTHON_USEDEP}]
"

S=${WORKDIR}/${P}/tools/Jupyter/kernel

src_unpack() {
	if [[ ${PV} -eq 9999 ]]; then
		git-r3_fetch cling
	else
		git-r3_fetch cling v${PV}
	fi
	git-r3_checkout cling "${WORKDIR}/${P}"
}

python_install_all() {
        distutils-r1_python_install_all
	if use cpp11 || use cpp14 || use cpp17 || use cpp1z ; then
		if use cpp11 ; then
			insinto /usr/share/jupyter/kernels/cpp11
			doins ${S}/cling-cpp11/kernel.json
			doins ${FILESDIR}/logo-32x32.png
			doins ${FILESDIR}/logo-64x64.png
			doins ${FILESDIR}/logo-svg.svg
		fi
		if use cpp14 ; then
			insinto /usr/share/jupyter/kernels/cpp14
			doins ${S}/cling-cpp14/kernel.json
			doins ${FILESDIR}/logo-32x32.png
			doins ${FILESDIR}/logo-64x64.png
			doins ${FILESDIR}/logo-svg.svg
		fi
		if use cpp17 ; then
			insinto /usr/share/jupyter/kernels/cpp17
			doins ${S}/cling-cpp17/kernel.json
			doins ${FILESDIR}/logo-32x32.png
			doins ${FILESDIR}/logo-64x64.png
			doins ${FILESDIR}/logo-svg.svg
		fi
		if use cpp1z ; then
			insinto /usr/share/jupyter/kernels/cpp1z
			doins ${S}/cling-cpp1z/kernel.json
			doins ${FILESDIR}/logo-32x32.png
			doins ${FILESDIR}/logo-64x64.png
			doins ${FILESDIR}/logo-svg.svg
		fi
	fi
}
