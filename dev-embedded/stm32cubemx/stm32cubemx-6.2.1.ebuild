# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

FN="en.stm32cubemx-lin_v6-2-1.zip"

DESCRIPTION="A graphical tool that allows a very easy configuration of STM32 microcontrollers and microprocessors"
HOMEPAGE="https://www.st.com/en/development-tools/stm32cubemx.html"
SRC_URI="${DISTDIR}/${FN}"
LICENSE="https://www.st.com/resource/en/license/SLA0048_STM32CubeIDE.pdf"

SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip fetch"

pkg_nofetch() {
    einfo
    einfo Please download ${FN} from 
    einfo https://www.st.com/en/development-tools/stm32cubemx.html#get-software
    einfo to ${PORTAGE_ACTUAL_DISTDIR}
    einfo
}

src_unpack() {
    default
    S=${WORKDIR}
}

src_compile() {
    echo
}

src_install() {
    ./SetupSTM32CubeMX-6.2.1 ${FILESDIR}/auto.xml
    echo '/bin/bash -c "cd /opt/STMicroelectronics/STM32Cube/STM32CubeMX/ && exec ./STM32CubeMX & disown"' > stm32cubemx
    insinto /usr/bin
    dobin stm32cubemx
    dosym ${EPREFIX}/usr/bin/stm32cubemx ${EPREFIX}/usr/bin/cubemx
}
