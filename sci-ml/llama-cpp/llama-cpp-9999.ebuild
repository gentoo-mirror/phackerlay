# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ROCM_VERSION="6.3"

inherit cmake rocm
inherit git-r3

# EGIT_COMMIT="v${PV}"
EGIT_REPO_URI="https://github.com/ggml-org/llama.cpp"

DESCRIPTION="Port of Facebook's LLaMA model in C/C++"
HOMEPAGE="https://github.com/ggml-org/llama.cpp"

LICENSE="MIT"
SLOT="0"
IUSE="curl"

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

src_configure() {
	local mycmakeargs=(
		-DLLAMA_BUILD_TESTS=OFF
		-DLLAMA_BUILD_SERVER=ON
		-DCMAKE_SKIP_BUILD_RPATH=ON
		-DLLAMA_CURL=$(usex curl ON OFF)
		-DBUILD_NUMBER="1"
		-DLLAMA_USE_SYSTEM_GGML=ON
	)

	cmake_src_configure
}
