# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR="emake"

inherit cmake git-r3 flag-o-matic

DESCRIPTION="Interactive C++ interpreter, built on the top of LLVM and Clang libraries"
HOMEPAGE="https://root.cern/cling/"

EGIT_OVERRIDE_REPO_LLVM_CLING="https://github.com/root-project/llvm-project.git"
EGIT_TAG_LLVM_CLING="cling-latest"
EGIT_OVERRIDE_REPO_CLING="https://github.com/root-project/cling.git"
if [[ ! "${PV}"="9999" ]]; then
        EGIT_REF="v${PV}"
else
        EGIT_REF="master"
fi


LICENSE="Apache-2.0" # more
SLOT="0"
KEYWORDS=""
IUSE="-llvm-tools -llvm-rtti"
RESTRICT="mirror"

src_unpack() {
	git-r3_fetch llvm-cling $EGIT_TAG_LLVM_CLING
	git-r3_checkout llvm-cling "${WORKDIR}/${P}"
	git-r3_fetch cling $EGIT_REF
	git-r3_checkout cling "${WORKDIR}/${P}/cling"
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="/opt/cling"
		-DCMAKE_BUILD_TYPE=Release
		-DLLVM_ENABLE_PROJECTS="clang"
		-DLLVM_EXTERNAL_CLING_SOURCE_DIR="${WORKDIR}/${P}/cling"
		-DLLVM_ENABLE_OCAMLDOC=OFF
		-DLLVM_ENABLE_BINDINGS=OFF
		-DLLVM_INCLUDE_DOCS=OFF
		-DBUILD_SHARED_LIBS=OFF
		-DLLVM_ENABLE_RTTI=$(usex llvm-rtti ON OFF)
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
              elog "	See dev-python/cling-kernels or dev-cpp/xeus-cling for jupyter kernels"
              elog
        fi
}
