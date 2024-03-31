# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

OCTAVE_PKG="jsonlab-2.0"

inherit octave-deb

DESCRIPTION="JSONLab: compact, portable, robust JSON/binary-JSON encoder/decoder for MATLAB/Octave"
HOMEPAGE="https://github.com/fangq/jsonlab"
SRC_URI="https://deb.debian.org/debian/pool/main/o/octave-jsonlab/octave-jsonlab_2.0-1.1_all.deb -> ${P}.deb"

LICENSE="BSD"
SLOT="0"

KEYWORDS="~amd64"
