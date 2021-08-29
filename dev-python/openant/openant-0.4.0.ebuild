# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )

inherit distutils-r1

DESCRIPTION="ANT and ANT-FS Python Library"
HOMEPAGE="https://github.com/Tigge/openant"
SRC_URI="https://github.com/Tigge/openant/archive/refs/tags/v0.4.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
    >=dev-python/pyusb-1.0[${PYTHON_USEDEP}]
	"

distutils_enable_tests pytest

src_unpack() {
	default
	mv * ${P}
	sed -i "s:/etc/udev/rules.d:${D}/lib/udev/rules.d:g" ${S}/setup.py || die
	sed -i "s:execute(udev:# execute(udev:g" ${S}/setup.py || die
}

src_prepare() {
	distutils-r1_src_prepare
}

python_compile() {
	distutils-r1_python_compile
}

python_install() {
	insinto /lib/udev/rules.d
	doins ${S}/resources/ant-usb-sticks.rules
	distutils-r1_python_install --skip-build
	udevadm control --reload-rules
}

python_install_all() {
	distutils-r1_python_install_all
}
