# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

inherit unpacker

EXPORT_FUNCTIONS src_install pkg_postinst pkg_postrm

IDEPEND="
	sci-mathematics/octave[zlib]
"

S=$WORKDIR

octave-deb_src_install(){
	rm ${S}/usr/share/doc/${PN}/NEWS ${S}/usr/share/doc/${PN}/*.gz
        insinto /usr/share/octave/packages
        doins -r ${S}/usr/share/octave/packages/${OCTAVE_PKG}
        dodoc -r ${S}/usr/share/doc/${PN}
}

octave-deb_pkg_postinst(){
        octave --eval 'pkg rebuild' 2>&1 >> /dev/null || die "could not run octave"
}
octave-deb_pkg_postrm(){
	octave --eval 'pkg rebuild' 2>&1 >> /dev/null
}
