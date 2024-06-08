# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Lapack headers substitute"
HOMEPAGE=""
SRC_URI=""

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+blas_openblas"

REQUIRED_USE="
	^^ ( blas_openblas )
"

DEPEND="
	blas_openblas? ( sci-libs/openblas )
"

# otherwise ${S} is inexistent
S=$WORKDIR

src_install(){
	if use blas_openblas; then
		dosym ${EPREFIX}/usr/lib64/pkgconfig/openblas.pc ${EPREFIX}/usr/lib64/pkgconfig/lapack.pc
		dosym ${EPREFIX}/usr/lib64/pkgconfig/openblas.pc ${EPREFIX}/usr/lib64/pkgconfig/cblas.pc
		dosym ${EPREFIX}/usr/lib64/pkgconfig/openblas.pc ${EPREFIX}/usr/lib64/pkgconfig/blas.pc
	fi
}
