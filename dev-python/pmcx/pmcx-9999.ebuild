# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11} )
DISTUTILS_USE_PEP517=setuptools
EGIT_REPO_URI="https://group_54_bot_0f234aadd242861369f21b3999477282:glpat-yNsGs-ZYAiFGHwcjdUpe@gitlab.phys-el.ru/sugarshine/pmcx.git"

inherit git-r3 distutils-r1

PROPERTIES="live"

DESCRIPTION="Python interface to MCX (this is original Fang's module, just with inverted inclusion policy)"
HOMEPAGE="https://gitlab.phys-el.ru/sugarshine/pmcx"
KEYWORDS=""
LICENSE="GPL-3"
SLOT="0"
IUSE=""
RDEPEND="
	dev-python/numpy
"
BDEPEND="
	dev-util/nvidia-cuda-toolkit
"
