# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Jupyter kernel for the C++ programming language"
HOMEPAGE="https://github.com/jupyter-xeus/xeus-cling"
SRC_URI="https://github.com/jupyter-xeus/xeus-cling/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=dev-cpp/xeus-zmq-1.0.0
	<dev-cpp/xeus-zmq-2.0.0
	>=dev-cpp/xtl-0.7.0
	<dev-cpp/xtl-0.8.0
	dev-cpp/cling[llvm-tools]
	>=dev-libs/pugixml-1.8.1
	>=net-libs/cppzmq-4.3.0
	>=dev-cpp/argparse-2.9
	>=dev-cpp/nlohmann_json-3.6.1"

RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	mycmakeargs=(
		-DLLVM_CONFIG=/opt/cling/bin/llvm-config
		-DCMAKE_PROGRAM_PATH=/opt/cling/bin
		-DCMAKE_PREFIX_PATH=/opt/cling
	)
	cmake_src_configure
}
