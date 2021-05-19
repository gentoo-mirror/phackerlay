# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9} )

inherit distutils-r1

DESCRIPTION="JupyterLab computational environment"
HOMEPAGE="https://github.com/jupyterlab/jupyterlab"
SRC_URI="https://github.com/jupyterlab/jupyterlab/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+ipympl slurm"

RDEPEND="
	dev-python/ipython[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	>=www-servers/tornado-6.1[${PYTHON_USEDEP}]
	dev-python/jupyter_core[${PYTHON_USEDEP}]
	=dev-python/jupyterlab_server-2.3.0[${PYTHON_USEDEP}]
	=dev-python/jupyter_server-1.4.0[${PYTHON_USEDEP}]
	=dev-python/nbclassic-0.2.6[${PYTHON_USEDEP}]
	>=dev-python/jinja-2.1[${PYTHON_USEDEP}]
	ipympl? ( >=dev-python/ipympl-0.7[${PYTHON_USEDEP}] )
        slurm? ( dev-python/jupyterlab-slurm[${PYTHON_USEDEP}] )
	net-libs/nodejs
"

src_prepare() {
	distutils-r1_src_prepare
}

python_compile() {
	distutils-r1_python_compile
}

python_install() {
	distutils-r1_python_install --skip-build
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
