# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 flag-o-matic

DESCRIPTION="Jupyter kernel for the C++ programming language"
HOMEPAGE="https://github.com/jupyter-xeus/xeus-cling"
EGIT_REPO_URI="https://github.com/jupyter-xeus/xeus-cling.git"
EGIT_COMMIT="${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="-cpp11 -cpp14 cpp17"

DEPEND="
	>=dev-cpp/xeus-zmq-1.0.0
	<dev-cpp/xeus-zmq-2.0.0
	>=dev-cpp/xtl-0.7.0
	<dev-cpp/xtl-0.8.0
	=dev-cpp/cling-0.8[llvm-tools,llvm-rtti]
	>=dev-libs/pugixml-1.8.1
	>=net-libs/cppzmq-4.3.0
	>=dev-cpp/argparse-2.9
	>=dev-cpp/nlohmann_json-3.6.1"

RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}/kernel-names.patch"
)

src_prepare() {
	cmake_src_prepare
	cd ${S}
	git revert 06ebeff --no-commit
}

src_configure() {
	mycmakeargs=(
		-DLLVM_CONFIG=/opt/cling/bin/llvm-config
		-DCMAKE_PROGRAM_PATH=/opt/cling/bin
		-DCMAKE_PREFIX_PATH=/opt/cling
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	use cpp11 || rm -r ${D}/usr/share/jupyter/kernels/xcpp11
	use cpp14 || rm -r ${D}/usr/share/jupyter/kernels/xcpp14
	use cpp17 || rm -r ${D}/usr/share/jupyter/kernels/xcpp17

}
