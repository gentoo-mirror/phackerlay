# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR="emake"

inherit cmake git-r3 flag-o-matic

DESCRIPTION="Interactive C++ interpreter, built on the top of LLVM and Clang libraries"
HOMEPAGE="https://root.cern/cling/"

EGIT_OVERRIDE_REPO_LLVM_CLING="http://root.cern/git/llvm.git"
EGIT_TAG_LLVM_CLING="cling-v0.6"
EGIT_OVERRIDE_REPO_CLING="http://root.cern/git/cling.git"
EGIT_TAG_CLING="v${PV}"
EGIT_OVERRIDE_REPO_CLANG_CLING="http://root.cern/git/clang.git"
EGIT_TAG_CLANG_CLING="cling-v${PV}"

PATCHES="
	${FILESDIR}/cling-0.8-no-tools.patch
"

LICENSE="Apache-2.0" # more
SLOT="0"
KEYWORDS="~amd64"
IUSE="-llvm-tools"
RESTRICT="mirror"

src_unpack() {
	git-r3_fetch llvm-cling $EGIT_TAG_LLVM_CLING
	git-r3_checkout llvm-cling "${WORKDIR}/${P}"
	git-r3_fetch cling $EGIT_TAG_CLING
	git-r3_checkout cling "${WORKDIR}/${P}/tools/cling"
	git-r3_fetch clang-cling $EGIT_TAG_CLANG_CLING
	git-r3_checkout clang-cling "${WORKDIR}/${P}/tools/clang"
}

#src_prepare() {
	# https://github.com/root-project/cling/issues/297
#	cd ${WORKDIR}/${P}/tools/cling
#	git cherry-pick 2c92b57
#        git rm tools/packaging/cpt.py
#	git -c core.editor=true cherry-pick --continue
#        cd ${WORKDIR}/${P}
#	cmake_src_prepare
#}

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
}

pkg_postinst() {
	if ! has_version dev-python/cling-kernels ;
	then
              elog
              elog "	See dev-python/cling-kernels for jupyter kernels"
              elog
        fi
}
