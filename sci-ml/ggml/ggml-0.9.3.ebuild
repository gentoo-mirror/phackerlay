# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ROCM_VERSION=6.3
inherit rocm
inherit cmake

DESCRIPTION="Tensor library for machine learning"
HOMEPAGE="https://github.com/ggml-org/ggml"
SRC_URI="https://github.com/ggml-org/ggml/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

X86_CPU_FLAGS=(
	sse4_2
	avx
	f16c
	avx2
	bmi2
	fma3
	avx512f
	avx512vbmi
	avx512_vnni
	avx_vnni
)
CPU_FLAGS=( "${X86_CPU_FLAGS[@]/#/cpu_flags_x86_}" )
IUSE="${CPU_FLAGS[*]} +blas mkl +rocm +openmp"

RESTRICT="test"

COMMON_DEPEND="
	blas? (
		!mkl? (
			virtual/blas
		)
		mkl? (
			sci-libs/mkl
		)
	)
	rocm? (
		>=sci-libs/hipBLAS-5.5:=[${ROCM_USEDEP}]
	)
"


src_configure() {
        local mycmakeargs=(
                -DBUILD_SHARED_LIBS=ON
		-DGGML_OPENMP=$(usex openmp ON OFF)
		-DGGML_SSE42=$(usex cpu_flags_x86_sse4_2 ON OFF)
		-DGGML_AVX=$(usex cpu_flags_x86_avx ON OFF)
		-DGGML_AVX_VNNI=$(usex cpu_flags_x86_avx_vnni ON OFF)
		-DGGML_F16C=$(usex cpu_flags_x86_f16c ON OFF)
		-DGGML_AVX2=$(usex cpu_flags_x86_avx2 ON OFF)
		-DGGML_BMI2=$(usex cpu_flags_x86_bmi2 ON OFF)
		-DGGML_FMA=$(usex cpu_flags_x86_fma3 ON OFF)
		-DGGML_AVX512=$(usex cpu_flags_x86_avx512f ON OFF)
		-DGGML_AVX512_VBMI=$(usex cpu_flags_x86_avx512vbmi ON OFF)
		-DGGML_AVX512_VNNI=$(usex cpu_flags_x86_avx512_vnni ON OFF)
#		-DGGML_=$(usex cpu_flags_x86_ ON OFF)
        )

	if use blas; then
		if use mkl; then
			mycmakeargs+=(
				-DGGML_BLAS_VENDOR="Intel"
			)
		else
			mycmakeargs+=(
				-DGGML_BLAS_VENDOR="Generic"
			)
		fi
	fi

	if use rocm; then
		mycmakeargs+=(
			-DGGML_HIP=ON
			-DCMAKE_HIP_ARCHITECTURES="$(get_amdgpu_flags)"
			-DCMAKE_HIP_PLATFORM="amd"
		)

		local -x HIP_PATH="${ESYSROOT}/usr"

		check_amdgpu
	else
		mycmakeargs+=(
			-DCMAKE_HIP_COMPILER="NOTFOUND"
		)
	fi

	cmake_src_configure
}
