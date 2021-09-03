EAPI=7

DESCRIPTION="autobuilding kernel with olddefconfig"
HOMEPAGE="https://daniel-lange.com/archives/169-Compiling-and-installing-the-Gentoo-Linux-kernel-on-emerge-without-genkernel.html"
SRC_URI="https://daniel-lange.com/archives/169-Compiling-and-installing-the-Gentoo-Linux-kernel-on-emerge-without-genkernel.html"

LICENSE="Artistic"
KEYWORDS="amd64 ~ppc ~ppc64 x86 arm arm64"
IUSE=""
SLOT="0"

DEPEND="sys-kernel/gentoo-sources[symlink]"

S="${WORKDIR}/"

src_install() {
	insinto /etc/portage/env/sys-kernel
	doins ${FILESDIR}/gentoo-sources
}
