# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
 
EAPI=7
 
inherit git-r3

DESCRIPTION="Wine driver and software installer for hantek 6082 scope"
HOMEPAGE="https://github.com/AlexUg/hantekdso.sys.git"

EGIT_REPO_URI="https://github.com/AlexUg/hantekdso.sys.git"
SRC_URI="http://www.hantek.com/Product/Hantek6000/HT6082_Software.zip"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

 
DEPEND=">=dev-libs/libusb-1 >=app-emulator/wine-vanilla-4.0[threads] >=app-emulator/wine-vanilla-4.0[usb] virtual/udev sys-apps/fxload"
RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}/${P}/hantekdso.sys
WINEPREFIX=.wine_hantek



src_configure() {
    sed -i "3s/.*/WINEPREFIX        =   ${WINEPREFIX}/" Makefile
    sed -i '4s/.*/USER        =   root/' Makefile
    WINE=`wine --version | sed 's:-:-vanilla-:g'`
    sed -i "5s:.*:WINE_LIBS_PATH        =   ${D}/usr/lib/$WINE/wine:" Makefile
    sed -i 's:/home/$(USER)/$(WINEPREFIX):${D}/usr/share/wine-hantek:g' Makefile
}

src_install() {
    mkdir ${D}/usr/share/wine-hantek/drive_c/windows/syswow64/drivers -p
    mkdir ${D}/usr/lib/$WINE/wine -p
    mkdir ${D}/lib/udev/rules.d -p
    cp ${DISTDIR}/HT6082_Software.zip ${D}/usr/share/wine-hantek/
    cp ./resources/hantekdso.reg ${D}/usr/share/wine-hantek/
    cp ./resources/hantekdso64.reg ${D}/usr/share/wine-hantek/
    cp ./resources/Hantek6082BEAMD641.sys.0x1290.hex ${D}/usr/share/wine-hantek/
    cp ./resources/Hantek6082BEAMD641.sys.0x17C0.hex ${D}/usr/share/wine-hantek/
    cp ${FILESDIR}/90-Hantek.rules ${D}/lib/udev/rules.d/
    default
    dobin ${FILESDIR}/hantek
    #ln -s ${D}/usr/lib/$WINE/wine/ -p

}
