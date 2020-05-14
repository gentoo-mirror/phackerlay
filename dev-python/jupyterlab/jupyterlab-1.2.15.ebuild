# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="JupyterLab computational environment"
HOMEPAGE="https://github.com/jupyterlab/jupyterlab"
SRC_URI="https://github.com/jupyterlab/jupyterlab/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT=network-sandbox

IUSE="+ipympl"

RDEPEND="\
	ipympl? ( dev-python/ipympl )
	>=dev-python/notebook-4.3.1 \
	>=dev-python/jinja-2 \
	>www-servers/tornado-6.0.2 \
	>=dev-python/jupyterlab-server-1.1.0 \
	sys-apps/yarn \
"

src_prepare() {
        einfo
	einfo 'Note, allowing network access from the sandbox via RESTRICT=network-sandbox'
	einfo '(needed for building jupyterlab assets via npm)'
        einfo
	distutils-r1_src_prepare
}

python_compile() {
	distutils-r1_python_compile
	mkdir -p assets/lab
	jupyter lab build --app-dir=${S}/assets/lab --debug
	if use ipympl; then
		jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-matplotlib --app-dir=${S}/assets/lab --debug
		rm ${S}/assets/lab/extensions/jupyter-matplotlib-*.tgz
	fi
}

python_install() {
	mkdir ${D}/usr/share/jupyter/lab -p
	cp -ar ${S}/assets/lab/* ${D}/usr/share/jupyter/lab/
	distutils-r1_python_install --skip-build
}

python_install_all() {
	distutils-r1_python_install_all
}
