# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit systemd distutils-r1

DESCRIPTION="The most powerful and modular diffusion model GUI, api and backend with a graph/nodes interface"
HOMEPAGE="https://github.com/comfyanonymous/ComfyUI"
LICENSE="GPL-3"
SLOT="0"

IUSE="systemd"

REQUIRED_USE=""

# https://github.com/comfyanonymous/ComfyUI/blob/master/requirements.txt
BDEPEND="
	=sci-ml/comfyui-frontend-package-1.26.13[${PYTHON_USEDEP}]
	=sci-ml/comfyui-workflow-templates-0.1.86[${PYTHON_USEDEP}]
	=sci-ml/comfyui-embedded-docs-0.2.6[${PYTHON_USEDEP}]
	sci-ml/pytorch[${PYTHON_USEDEP}]
	sci-ml/torchsde[${PYTHON_USEDEP}]
	sci-ml/torchvision[${PYTHON_USEDEP}]
	sci-ml/torchaudio[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.25.0[${PYTHON_USEDEP}]
	dev-python/einops[${PYTHON_USEDEP}]
	>=sci-ml/transformers-4.37.2[${PYTHON_USEDEP}]
	>=sci-ml/tokenizers-0.13.3[${PYTHON_USEDEP}]
	sci-ml/sentencepiece[${PYTHON_USEDEP}]
	>=sci-ml/safetensors-0.4.2[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3.11.8[${PYTHON_USEDEP}]
	>=dev-python/yarl-1.18.0[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/alembic[${PYTHON_USEDEP}]
	dev-python/sqlalchemy[${PYTHON_USEDEP}]
	>=dev-python/av-14.2.0[${PYTHON_USEDEP}]
"

RDEPEND="
    acct-user/genai
    acct-group/genai
"

DEPEND=""

#INSTALL_DIR="/opt/comfyui/"
#CONFIG_DIR="/etc/comfyui"

SRC_URI="https://github.com/comfyanonymous/ComfyUI/archive/refs/tags/v${PV}.tar.gz -> ${MY_P}.tar.gz"
#KEYWORDS="~amd64 ~arm ~arm64 ~x86"

src_install() {
	default
#    if use systemd; then
#        systemd_newunit "${FILESDIR}"/comfyui.service comfyui.service
#    fi
}

pkg_prerm() {
    if use systemd; then
        einfo "Stopping systemd services."
        systemctl daemon-reload
        systemctl stop comfyui.service
    fi
}

pkg_postrm() {
    if use systemd; then
        einfo "Restarting systemd daemon."
        systemctl daemon-reload
    fi
}
