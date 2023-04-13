# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )
CMAKE_MAKEFILE_GENERATOR="emake"

inherit cmake git-r3 flag-o-matic distutils-r1

DESCRIPTION="Interactive C++ interpreter, built on the top of LLVM and Clang libraries"
HOMEPAGE="https://root.cern/cling/"

EGIT_OVERRIDE_REPO_LLVM_CLING="http://root.cern/git/llvm.git"
EGIT_TAG_LLVM_CLING="cling-patches-rrelease_13"
EGIT_OVERRIDE_REPO_CLING="http://root.cern/git/cling.git"
EGIT_OVERRIDE_REPO_CLANG_CLING="http://root.cern/git/clang.git"
EGIT_TAG_CLANG_CLING="cling-patches-rrelease_13"

LICENSE="Apache-2.0" # more
SLOT="0"
KEYWORDS=""
IUSE="-llvm-tools -cpp11 -cpp14 cpp17 -cpp1z"
RESTRICT="mirror"

DEPEND="
	cpp11? ( dev-python/ipykernel[${PYTHON_USEDEP}] dev-python/traitlets[${PYTHON_USEDEP}] )
	cpp14? ( dev-python/ipykernel[${PYTHON_USEDEP}] dev-python/traitlets[${PYTHON_USEDEP}] )
	cpp17? ( dev-python/ipykernel[${PYTHON_USEDEP}] dev-python/traitlets[${PYTHON_USEDEP}] )
	cpp1z? ( dev-python/ipykernel[${PYTHON_USEDEP}] dev-python/traitlets[${PYTHON_USEDEP}] )
"


src_unpack() {
	git-r3_fetch llvm-cling $EGIT_TAG_LLVM_CLING
	git-r3_checkout llvm-cling "${WORKDIR}/${P}"
	git-r3_fetch cling
	git-r3_checkout cling "${WORKDIR}/${P}/tools/cling"
	git-r3_fetch clang-cling $EGIT_TAG_CLANG_CLING
	git-r3_checkout clang-cling "${WORKDIR}/${P}/tools/clang"
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="/opt/cling"
		-DCMAKE_BUILD_TYPE=Release
		-DLLVM_TOOL_CLING_BUILD=ON
		-DLLVM_TARGETS_TO_BUILD="host;NVPTX"
		-DLLVM_ENABLE_OCAMLDOC=OFF
		-DLLVM_ENABLE_BINDINGS=OFF
		-DLLVM_INCLUDE_DOCS=OFF
		-DBUILD_SHARED_LIBS=OFF
		-DLLVM_BUILD_TOOLS=$(usex llvm-tools ON OFF)
		-DLLVM_CONFIG=${BUILD_DIR}/bin/llvm-config
		-DLLVM_BINARY_DIR=${BUILD_DIR}
		-DLLVM_LIBRARY_DIR=${BUILD_DIR}/lib
		-DLLVM_MAIN_INCLUDE_DIR=${BUILD_DIR}/include
		-DLLVM_TABLEGEN_EXE=${BUILD_DIR}/bin/llvm-tablegen
		-DLLVM_TOOLS_BINARY_DIR=${BUILD_DIR}/bin
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	dosym ../cling/bin/cling "/opt/bin/cling"

	if use cpp11 || use cpp14 || use cpp17 || use cpp1z ; then
		OLD_S=${S}
		S=${WORKDIR}/${P}/tools/cling/tools/Jupyter/kernel
		distutils-r1_python_install_all
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
		S=${OLD_S}
	fi
}
