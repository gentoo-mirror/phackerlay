# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit autotools python-single-r1

DESCRIPTION="Dynamic modification of a user's environment via modulefiles"
HOMEPAGE="http://modules.sourceforge.net/"
SRC_URI="https://github.com/cea-hpc/modules/releases/download/v${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	${PYTHON_DEPS}
	dev-lang/tcl:0=
"

RDEPEND="
	${DEPEND}
"

src_prepare() {
	default

	cd "${S}/lib" || die
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-versioning
		--with-initconf-in=etcdir
		--enable-multilib-support
		--disable-set-shell-startup
		--prefix="${EPREFIX}/usr/share/Modules"
		--mandir="${EPREFIX}/usr/share/man"
		--docdir="${EPREFIX}/usr/share/doc/${P}"
		--libdir="${EPREFIX}/usr/share/Modules/$(get_libdir)"
		--datarootdir="${EPREFIX}/usr/share"
		--modulefilesdir="${EPREFIX}/etc/modulefiles"
		--with-tcl="${EPREFIX}/usr/$(get_libdir)"
		--with-python="${PYTHON}"
		--with-quarantine-vars="LD_LIBRARY_PATH LD_PRELOAD"
	)
	econf "${myconf[@]}" "${EXTRA_ECONF[@]}" || die "configure failed"
}

src_install() {
	default
	dosym ../../usr/share/Modules/init/profile.sh /etc/profile.d/modules.sh
	dosym ../../usr/share/Modules/init/profile.csh /etc/profile.d/modules.csh
	dodir /etc/modulefiles
}
