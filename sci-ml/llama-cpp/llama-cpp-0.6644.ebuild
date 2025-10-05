# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ROCM_VERSION="6.3"

inherit cmake rocm

BUILD_NUMBER=6644

DESCRIPTION="Port of Facebook's LLaMA model in C/C++"
HOMEPAGE="https://github.com/ggml-org/llama.cpp"
SRC_URI="https://github.com/ggml-org/llama.cpp/archive/refs/tags/b${BUILD_NUMBER}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
IUSE="+curl +server"
KEYWORDS="~amd64"

# curl is needed for pulling models from huggingface
# numpy is used by convert_hf_to_gguf.py
CDEPEND="
	curl? ( net-misc/curl:= )
"
DEPEND="${CDEPEND}
	sci-ml/ggml
"
RDEPEND="${CDEPEND}
	dev-python/numpy
"

S=${WORKDIR}/llama.cpp-b${BUILD_NUMBER}

src_configure() {
	local mycmakeargs=(
		-DLLAMA_BUILD_TESTS=OFF
		-DLLAMA_BUILD_SERVER=$(usex server ON OFF)
		-DCMAKE_SKIP_BUILD_RPATH=ON
		-DLLAMA_CURL=$(usex curl ON OFF)
		-DBUILD_NUMBER=${BUILD_NUMBER}
		-DLLAMA_USE_SYSTEM_GGML=ON
	)

	cmake_src_configure
}
