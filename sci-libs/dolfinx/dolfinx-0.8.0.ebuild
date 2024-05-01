# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Next generation FEniCS problem solving environment"
HOMEPAGE="
	https://github.com/FEniCS/dolfinx
"
SRC_URI="https://github.com/FEniCS/dolfinx/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"


BDEPEND="
	sci-mathematics/petsc[boost,hdf5,metis,scotch,mpi]
        dev-libs/pugixml
        dev-python/fenics-ffcx
        dev-python/fenics-basix
	sci-libs/hdf5
"

src_unpack() {
	default
	S=${WORKDIR}/${P}/cpp
}
