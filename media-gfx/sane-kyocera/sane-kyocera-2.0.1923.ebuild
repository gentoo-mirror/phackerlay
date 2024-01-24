# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker udev

DESCRIPTION="Linux scanner driver for Kyocera MFP and Scanner devices"
HOMEPAGE="https://www.kyoceradocumentsolutions.us"
SRC_URI="https://www.kyoceradocumentsolutions.us/content/download-center-americas/us/drivers/drivers/KyoceraSANE_v2_0_1923_zip.download.zip -> ${P}.zip"

LICENSE="kyocerasane"
SLOT="0"

RESTRICT="bindist mirror splitdebug test"

QA_PREBUILT="*"
RDEPEND="
	dev-libs/openssl-compat
	media-libs/tiff-compat
	media-gfx/sane-backends
	dev-libs/libusb
"

KEYWORDS="~amd64"
S=$WORKDIR

src_unpack() {
	default
	unpack_deb kyocera-sane_${PV}_amd64.deb
	gunzip usr/share/man/man1/kyocera-sane.1.gz
}


src_install() {
	insinto /lib/udev/rules.d
	doins etc/udev/rules.d/40-scanner-permissions.rules
	insinto /etc/sane.d
	doins etc/sane.d/kyocera*
	dodoc usr/share/man/man1/kyocera-sane.1
	dolib.so usr/lib/libkmadrwapi.so
	dolib.so usr/lib/libkmcmnapi2.so
	dolib.so usr/lib/libkmencapi.so
	dolib.so usr/lib/libkmip.so.1.0.705
	dosym ${EPREFIX}/usr/$(get_libdir)/libkmip.so.1.0.705 ${EPREFIX}/usr/$(get_libdir)/libkmip.so.1
	dolib.so usr/lib/libkmscnapi.so
	dodir /usr/$(get_libdir)/sane
	insinto /usr/$(get_libdir)/sane
	doins usr/lib/sane/libsane-kyocera_wc3.so.1.0.24
	dosym ${EPREFIX}/usr/$(get_libdir)/sane/libsane-kyocera_wc3.so.1.0.24 ${EPREFIX}/usr/$(get_libdir)/sane/libsane-kyocera_wc3.so.1
	doins usr/lib/sane/libsane-kyocera_wc3_usb.so.1.0.24
	dosym ${EPREFIX}/usr/$(get_libdir)/sane/libsane-kyocera_wc3_usb.so.1.0.24 ${EPREFIX}/usr/$(get_libdir)/sane/libsane-kyocera_wc3_usb.so.1
	dodoc usr/share/man/man1/kyocera-sane.1

	dodir /usr/local/$(get_libdir)
	insinto /usr/local/$(get_libdir)
	doins usr/local/kyocera/scanner/libjpeg.so.8.0.2
	dosym ${EPREFIX}/usr/local/$(get_libdir)/libjpeg.so.8.0.2 ${EPREFIX}/usr/local/$(get_libdir)/libjpeg.so.8
	doins usr/local/kyocera/scanner/libtiff.so.4.3.4
	dosym ${EPREFIX}/usr/local/$(get_libdir)/libtiff.so.4.3.4 ${EPREFIX}/usr/local/$(get_libdir)/libtiff.so.4

	touch kyocera
	# echo kyocera >> kyocera
	# echo kyocera_gdi_a3 >> kyocera
	echo kyocera_wc3 >> kyocera
	echo kyocera_wc3_usb >> kyocera
	insinto /etc/sane.d/dll.d
	doins kyocera
}

pkg_postrm() {
	udev_reload
}

pkg_postinst() {
	udev_reload
	elog
	elog 'Configuration for Network devices:'
	elog ''
	elog '  1. After installing the Debian package, open the following file in a text editor.'
	elog '       	/etc/sane.d/kyocera_devices.conf'
	elog ''
	elog '  2. Add the hostname/IP address and model of your device as "<Hostname> <ModelName>".'
	elog '       	E.g.'
	elog '       	PC12345 FS-1135MFP'
	elog '       	192.168.1.100 FS-1135MFP'
	elog ''
	elog '     You can add more than 1 device to the list (1 device per line).'
	elog '     Please refer to instructions provided in configuration file for more details.'
	elog
}

