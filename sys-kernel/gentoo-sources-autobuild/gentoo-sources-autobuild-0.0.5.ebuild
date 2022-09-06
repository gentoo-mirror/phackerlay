EAPI=7

DESCRIPTION="autobuilding kernel with olddefconfig"
HOMEPAGE="https://daniel-lange.com/archives/169-Compiling-and-installing-the-Gentoo-Linux-kernel-on-emerge-without-genkernel.html"

LICENSE="Artistic"
KEYWORDS="amd64 ~ppc ~ppc64 x86 arm arm64"
IUSE=""
SLOT="0"

IUSE="+eclean-kernel patch"

RDEPEND="
	sys-kernel/gentoo-sources[symlink]
	eclean-kernel? ( app-admin/eclean-kernel )
"

S="${WORKDIR}/"

src_install() {
	mkdir -p ${D}/etc/portage/env/sys-kernel
	f=${D}/etc/portage/env/sys-kernel/gentoo-sources
	echo 'post_pkg_postinst() {' > $f

	if use patch; then
		cat ${FILESDIR}/patch >> $f
	fi
	cat ${FILESDIR}/compile >> $f

	if use eclean-kernel; then
        	echo '	eclean-kernel -n 3' >> $f 
	fi
	echo '}' >> $f
}
