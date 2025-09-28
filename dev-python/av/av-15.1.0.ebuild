# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Pythonic bindings for FFmpeg's libraries"
HOMEPAGE="https://github.com/PyAV-Org/PyAV https://pypi.org/project/av/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="test"

DEPEND="media-video/ffmpeg"
