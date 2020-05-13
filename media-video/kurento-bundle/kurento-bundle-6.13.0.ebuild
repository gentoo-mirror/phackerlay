# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="WebRTC Media Server and a set of client APIs that simplify the development of advanced video applications for web and smartphone platforms.\
(orphaned, made it compile, then switched to attention to jitsi)"
HOMEPAGE="https://github.com/Kurento/kurento-media-server"

inherit git-r3 cmake

EGIT_REPO_URI="https://github.com/Kurento/kms-omni-build.git"
EGIT_BRANCH="master"

if [[ ${PV} == 9999 ]]; then
	KEYWORDS=""
else
	EGIT_COMMIT="${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0"
SLOT="0"

#CC="clang"
#CXX="clang++"
IUSE="+clang -test"

RDEPEND=""
DEPEND=""
BDEPEND="dev-libs/kms-jsoncpp
dev-java/maven-bin
clang? ( sys-devel/clang )
media-plugins/gst-plugins-libnice
media-plugins/gst-plugins-opencv
"
#=dev-libs/kms-cmake-utils-6.13

#RESTRICT=network-sandbox

src_unpack() {
	git-r3_fetch
	git-r3_checkout
	default
	find ${S} -type f -exec sed -e 's:-1.5:-1.0:g' -i '{}' \;
}

src_prepare() {
	eapply ${FILESDIR}/websocketpp-0.7.0-openssl11.patch
	default
}

src_configure() {
        export FINAL_INSTALL_DIR=/usr

if use clang
	then
	export CC='clang'
	export CXX='clang++'
else
	export CC='gcc'
	export CXX='g++'
fi
	cmake -S ${S} -B ${BUILD_DIR} -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_INSTALL_SYSCONFDIR=/etc -DGENERATE_TESTS=TRUE ${CMAKE_ARGS}
}

src_compile() {
	cd ${BUILD_DIR}
	make ${MAKEOPTS}
}

src_install() {
	make install
	insinto /etc/kurento
	doins "${S}"/kurento-media-server/kurento.conf.json
	exeinto /usr/bin
	doexe "${BUILD_DIR}"/kurento-media-server/server/kurento-media-server
	find ${BUILD_DIR} -type f -name '*.so*' -exec dolib.so '{}' \;
	dosym /usr/lib64/libkmssdpagent.so.6.13.0 /usr/lib64/libkmssdpagent.so.6
	dosym /usr/lib64/libkmsfiltersimpl.so.6.13.0 /usr/lib64/libkmsfiltersimpl.so.6
	dosym /usr/lib64/libwebrtcdataproto.so.6.13.0 /usr/lib64/libwebrtcdataproto.so.6
	dosym /usr/lib64/libkmscoreimpl.so.6.13.0 /usr/lib64/libkmscoreimpl.so.6
	dosym /usr/lib64/libkmselementsimpl.so.6.13.0 /usr/lib64/libkmselementsimpl.so.6
	dosym /usr/lib64/libkmswebrtcendpointlib.so.6.13.0 /usr/lib64/libkmswebrtcendpointlib.so.6
	dosym /usr/lib64/libjsonrpc.so.6.13.0 /usr/lib64/libjsonrpc.so.6
	dosym /usr/lib64/libkmsgstcommons.so.6.13.0 /usr/lib64/libkmsgstcommons.so.6

}


src_test() {
	export GST_DEBUG_NO_COLOR=1
	export GST_DEBUG="3,check:5"
	cmake_src_test
}

