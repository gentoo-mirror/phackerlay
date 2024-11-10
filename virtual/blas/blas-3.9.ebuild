# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Virtual for FORTRAN 77 BLAS implementation"
SLOT="0"
KEYWORDS=""
IUSE="eselect-ldso"

# sci-libs/lapack is really slow, shouldn't be default
RDEPEND="
	!eselect-ldso? ( >=sci-libs/lapack-3.10.0[-eselect-ldso] !!sci-libs/lapack-headers )
	eselect-ldso? ( || (
		>=sci-libs/lapack-3.10.0[eselect-ldso]
		sci-libs/openblas[eselect-ldso]
		sci-libs/blis[eselect-ldso] )
		sci-libs/lapack-headers
	)
	eselect-ldso? ( >=app-eselect/eselect-blas-0.2 )
"
DEPEND="${RDEPEND}"
