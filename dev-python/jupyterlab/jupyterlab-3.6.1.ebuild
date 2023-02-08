# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11} )

DISTUTILS_USE_PEP517="jupyter"
inherit distutils-r1

DESCRIPTION="JupyterLab computational environment"
HOMEPAGE="https://github.com/jupyterlab/jupyterlab"
SRC_URI="https://github.com/jupyterlab/jupyterlab/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests pytest

RDEPEND="
	dev-python/ipykernel[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	>=dev-python/tornado-6.2[${PYTHON_USEDEP}]
	dev-python/jupyter_core[${PYTHON_USEDEP}]
	=dev-python/jupyterlab_server-2*[${PYTHON_USEDEP}]
	>=dev-python/jupyterlab_server-2.19.0[${PYTHON_USEDEP}]
	>=dev-python/jupyter-lsp-1.5.1[${PYTHON_USEDEP}]
	=dev-python/jupyter_server-2*[${PYTHON_USEDEP}]
	>=dev-python/jupyter_ydoc-0.2.2[${PYTHON_USEDEP}]
	>=dev-python/jupyter_server_ydoc-0.6.0[${PYTHON_USEDEP}]
	>=dev-python/nbclassic-0.2[${PYTHON_USEDEP}]
	<dev-python/notebook-7[${PYTHON_USEDEP}]
	>=dev-python/jinja-3.0.3[${PYTHON_USEDEP}]
	dev-python/fastjsonschema[${PYTHON_USEDEP}]
	dev-python/tinycss2[${PYTHON_USEDEP}]
        dev-python/tomli[${PYTHON_USEDEP}]
        dev-python/traitlets[${PYTHON_USEDEP}]
"
DEPEND="
    net-libs/nodejs
"

RESTRICT="network-sandbox"

#    widgets? ( dev-python/ipywidgets[${PYTHON_USEDEP}] >dev-python/jupyterlab-widgets-1.0.0[${PYTHON_USEDEP}] )
# get installed to system path instead of JUPYTERLAB_DIR, do not work

src_prepare() {
	distutils-r1_src_prepare
}

python_compile() {
	distutils-r1_python_compile
}

python_install() {
	distutils-r1_python_install --skip-build
        mkdir -p ${D}/etc
        mv ${D}/usr/etc/* ${D}/etc/
        rm ${D}/usr/etc -r
        echo "export JUPYTERLAB_DIR=~/.jupyter/lab/assets" > jupyterlab-assets.sh
        insinto /etc/bash/bashrc.d
        doins ${S}/jupyterlab-assets.sh
}

python_install_all() {
	distutils-r1_python_install_all
}

pkg_postinst() {
    if [ "$JUPYTERLAB_DIR" = "" ]; then
        elog
        elog Before running jupyterlab in the existing shell please source
        elog . /etc/bash/bashrc.d/jupyterlab-assets.sh
        elog
    fi
}
