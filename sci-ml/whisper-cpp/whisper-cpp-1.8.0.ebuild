# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MyPN="whisper.cpp"
MyP="${MyPN}-${PV}"

DESCRIPTION="Port of OpenAI's Whisper model in C/C++ "
HOMEPAGE="https://github.com/ggml-org/whisper.cpp"
SRC_URI="https://github.com/ggml-org/whisper.cpp/archive/refs/tags/v${PV}.tar.gz -> ${MyP}.tar.gz"

S="${WORKDIR}/${MyP}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

BDEPEND="
	sci-ml/ggml
"
RDEPEND="
	${BDEPEND}
"

src_configure() {
	# Note: CUDA and HIP are currently untested. Build failures may occur.
	# Turning off examples causes errors during configure
	# -DWHISPER_BUILD_TESTS=$(usex test)
	local mycmakeargs=(
		-DWHISPER_BUILD_EXAMPLES=ON
		-DWHISPER_USE_SYSTEM_GGML=ON
	)
	cmake_src_configure
}
