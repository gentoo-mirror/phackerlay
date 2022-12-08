# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

DESCRIPTION="JSONLab: compact, portable, robust JSON/binary-JSON encoder/decoder for MATLAB/Octave"
HOMEPAGE="https://github.com/fangq/jsonlab"
SRC_URI="https://deb.debian.org/debian/pool/main/o/octave-jsonlab/octave-jsonlab_2.0-1.1_all.deb -> ${P}.deb"

LICENSE="BSD"
SLOT="0"

RDEPEND="
	sci-mathematics/octave[zlib]
"

KEYWORDS="~amd64"
S=$WORKDIR

src_install(){
	rm ${S}/usr/share/doc/octave-jsonlab/NEWS ${S}/usr/share/doc/octave-jsonlab/*.gz
	insinto /usr/share/octave/packages
	doins -r ${S}/usr/share/octave/packages/jsonlab-2.0
	dodoc -r ${S}/usr/share/doc/octave-jsonlab

}
